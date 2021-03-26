import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramen/common/navigation.dart';
import 'package:ramen/common/result_state.dart';
import 'package:ramen/data/model/ramen.dart';
import 'package:ramen/provider/db_provider.dart';
import 'package:ramen/ui/maps_page.dart';

class DialogRamen extends StatefulWidget {
  @override
  _DialogRamenState createState() => _DialogRamenState();
}

class _DialogRamenState extends State<DialogRamen> {

  bool _btnEnabled = false;
  bool _isSaved = false;
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
          );
      }
    );
  }

  contentBox(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child){
      return Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0,2),
            blurRadius: 6
            ),
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("New Ramen",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),
                onChanged: (text){
                  if(text.length>3){
                    setState(() {
                      _btnEnabled = true;
                    });
                  }else {
                    setState((){
                      _btnEnabled = false;
                    });
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  child: Text("Simpan", style: _btnEnabled ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),),
                  onPressed: _btnEnabled ? () async {
                    final ramen = Ramen(
                      name: _nameController.text,
                    );
                    Navigation.intentWithData(MapsPage.routeName, MapsArgument(ramen,  true));
                  } : null,
                  color: _btnEnabled ? Colors.blue : Colors.grey,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
      }
    );
  }
}