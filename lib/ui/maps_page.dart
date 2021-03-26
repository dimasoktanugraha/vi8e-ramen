import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ramen/common/navigation.dart';
import 'package:ramen/data/model/ramen.dart';
import 'package:ramen/provider/db_provider.dart';
import 'package:ramen/ui/ramen_page.dart';

class MapsPage extends StatefulWidget {

  static const routeName = '/maps_page';
  final MapsArgument ramen;

  const MapsPage({Key key, this.ramen}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
      
  @override
  Widget build(BuildContext context) {

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.ramen.ramen.latitude, widget.ramen.ramen.longitude),
      zoom: 14,
    );

    if (!widget.ramen.isAdd) {
      _markers.add(
        Marker(
          markerId: MarkerId(widget.ramen.ramen.id.toString()),
          position: LatLng(widget.ramen.ramen.latitude, widget.ramen.ramen.longitude),
          infoWindow: InfoWindow(
            title: widget.ramen.ramen.name,
            snippet: widget.ramen.ramen.name
          ) 
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ramen.ramen.name),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        onTap:  (LatLng point){
          if(widget.ramen.isAdd){
            final ramen = Ramen(
              name: widget.ramen.ramen.name,
              latitude: point.latitude,
              longitude: point.longitude
            );
            Provider.of<DatabaseProvider>(context, listen: false).addRamen(ramen);
            Navigation.intentClean(RamenPage.routeName);
            // _markers.add(Marker(
            //   markerId: MarkerId(point.toString()),
            //   position: point,
            //   infoWindow: InfoWindow(
            //     title: widget.ramen.ramen.name,
            //   ),
            // ));
          } 
        },
      ),
    );
  }

  _handleTap(LatLng point) async {
    widget.ramen.isAdd ??
      setState(() {
        final ramen = Ramen(
          name: widget.ramen.ramen.name,
          latitude: point.latitude,
          longitude: point.longitude
        );
        Provider.of<DatabaseProvider>(context, listen: false).addRamen(ramen);
        Navigation.intentClean(RamenPage.routeName);
        _markers.add(Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: widget.ramen.ramen.name,
          ),
        ));
    });
  }
}

class MapsArgument{
  Ramen ramen;
  bool isAdd;

  MapsArgument(this. ramen, this.isAdd);
}