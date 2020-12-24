import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppProvider with ChangeNotifier{
  
//Mixins - a class (AppProvider class) that can use the methods defined inside the ChangeNotifier class but 
//its not a child of this other class

Position position;
GoogleMapController _mapController;
LatLng _center;

LatLng get center =>  _center;
bool _hasLocationPermission;
bool _isLocationEnabled;

AppProvider.initialize(){
  _getUserLocation();
}

_getUserLocation() async {

position = await Geolocator.getCurrentPosition();
_center = LatLng(position.latitude, position.longitude);
notifyListeners();

}

onCreate(GoogleMapController controller){
_mapController = controller;
notifyListeners();
}


}