import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:jitney/helpers/constants.dart';
import 'package:jitney/helpers/style.dart';
import 'package:jitney/providers/app.dart';
import 'package:provider/provider.dart';


GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

class HomeScreen extends StatefulWidget {
HomeScreen({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
          key: scaffoldState,
          drawer: Drawer(
         child: ListView(
           children: [
             UserAccountsDrawerHeader(accountName: Text("Karios for now"), accountEmail: Text("karios@gmail.com")),
           ],
         ),
       ),
          body: MapScreen(scaffoldState),
          ),
    );
  }
  }


/**** 
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
  */
  

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  MapScreen(this.scaffoldState);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appState = Provider.of<AppProvider>(context);
    return appState.center == null
        ? Container(
            alignment: Alignment.center,
            child: Center(child: CircularProgressIndicator()),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                CameraPosition(target: appState.center, zoom: 13),
                onMapCreated: appState.onCreate,
                myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                markers: appState.markers,
                onCameraMove: appState.onCameraMove,
                polylines: appState.poly,
              ),
              Positioned(
                top: 10,
                left: 15,
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Primary,
                      size: 30,
                    ),
                    onPressed: () {
                      scaffoldSate.currentState.openDrawer();
                    }),
              ),

              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15.0),
                    child: RaisedButton(onPressed: ()async{
                        GeoFirePoint point = GeoFirePoint(appState.center.latitude, appState.center.longitude);
                        FirebaseFirestore.instance.collection("locations").add({
                          "points": point.data,
                          "name": "Driver"
                        });
                        print("it all worked");


                    }, color: darkBlue,
                      child: Text("Confirm Booking", style: TextStyle(color: Colors.white, fontSize: 16),),),
                  ),
                ),)
            ],
          );
  }

  Future<Null> displayPrediction(Prediction p) async {
       if (p != null) {
         PlacesDetailsResponse detail =
         await places.getDetailsByPlaceId(p.placeId);

         var placeId = p.placeId;
         double lat = detail.result.geometry.location.lat;
         double lng = detail.result.geometry.location.lng;

         var address = await Geocoder.local.findAddressesFromQuery(p.description);

         print(lat);
         print(lng);
       }
  }

}
