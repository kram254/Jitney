import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jitney/providers/app.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // using stacks so that we can add another widget on top of the other.
    return Scaffold(
      key: _key,
       drawer: Drawer(
         child: ListView(
           children: [
             UserAccountsDrawerHeader(accountName: Text("Karios for now"), accountEmail: Text("karios@gmail.com")),
           ],
         ),
       ),

          body: Stack(
          children: [
          MapScreen(scaffoldKey: _key),
        ],
      ),
    );
  
  }
}

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MapScreen({Key key, this.scaffoldKey}) : super(key: key);
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
          child: Scaffold(
        body: appProvider.center == null? CircularProgressIndicator: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
              target: appProvider.center,
              zoom: 13),
              onMapCreated: appProvider.onCreate,
              myLocationEnabled: true,
            ),

          Positioned(child: IconButton(icon: Icon(Icons.menu), onPressed:(){
            widget.scaffoldKey.currentState.openDrawer();
          })),

          ],
        ),
        
      ),
    );
  }

 
}