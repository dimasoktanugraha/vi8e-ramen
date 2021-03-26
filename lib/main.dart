import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramen/common/navigation.dart';
import 'package:ramen/ui/maps_page.dart';
import 'package:ramen/ui/ramen_page.dart';
import 'provider/db_provider.dart';
import 'data/local/database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
        title: 'Ramen',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RamenPage.routeName,
        routes: {
          RamenPage.routeName: (context) => RamenPage(),
          MapsPage.routeName: (context) => MapsPage(
            ramen: ModalRoute.of(context).settings.arguments
          ),
        },
      ),
    );
  }
} 