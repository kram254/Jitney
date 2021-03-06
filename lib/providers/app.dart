import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jitney/helpers/style.dart';
import 'package:jitney/models/route.dart';
import 'package:jitney/services/map_requests.dart';
import 'package:location/location.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======

>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
import 'package:uuid/uuid.dart';
import 'package:geocoding/geocoding.dart';

class AppProvider with ChangeNotifier{
  Set<Marker> _markers = {};
  Set<Polyline> _poly = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
//Mixins - a class (AppProvider class) that can use the methods defined inside the ChangeNotifier class but 
//its not a child of this other class

Position position;
GoogleMapController _mapController;
static LatLng _center;
LatLng _lastPosition = _center;
TextEditingController _locationController = TextEditingController();
TextEditingController destinationController = TextEditingController();
<<<<<<< HEAD
LatLng get center =>  _center;
LatLng get lastPosition => _lastPosition;
//bool _hasLocationPermission;
//bool _isLocationEnabled;
=======

LatLng get center =>  _center;
 LatLng get lastPosition => _lastPosition;
bool _hasLocationPermission;
bool _isLocationEnabled;
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
TextEditingController get locationController => _locationController;
Set<Marker> get markers => _markers;
Set<Polyline> get poly => _poly;
GoogleMapController get mapController => _mapController;
RouteModel routeModel;

<<<<<<< HEAD
//Location location  = new Location();


AppProvider(){
    _getUserLocation();
    Geolocator.getPositionStream().listen(_userCurrentLocationUpdate);
  }

  _userCurrentLocationUpdate(Position updatedPosition){
    FirebaseFirestore.instance.collection("locations").doc("VOYPizKCFocEmXKlZXzP").update({
      "position": updatedPosition.toJson(),
    });
  }

=======
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
AppProvider.initialize(){
  _getUserLocation();
}

_getUserLocation() async {
<<<<<<< HEAD

=======
  
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
position = await Geolocator.getCurrentPosition();
List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
_center = LatLng(position.latitude, position.longitude);
_locationController.text = placemark[0].name;
notifyListeners();

}

onCreate(GoogleMapController controller){
_mapController = controller;
notifyListeners();
}

setLastPosition(LatLng position){
    _lastPosition = position;
    notifyListeners();
}

onCameraMove(CameraPosition position) {
<<<<<<< HEAD
  print("driver moving");
    _lastPosition = position.target;
    notifyListeners();
=======
    _lastPosition = position.target;
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
}

_addLocationMarker(LatLng position, String destination, String distance) {
    _markers = {};
    var uuid = new Uuid();
    String markerId = uuid.v1();
      _markers.add(Marker(
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(title: destination, snippet: distance),
          icon: BitmapDescriptor.defaultMarker));
          notifyListeners();
  }

<<<<<<< HEAD
/*** 
=======
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
void _addDriverMarker(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    var uuid = new Uuid();
    String markerId = uuid.v1();
    _markers.add(Marker(
        markerId: MarkerId(markerId),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData)));
  }
<<<<<<< HEAD
  */
=======
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba

  void sendRequest({String intendedLocation, LatLng coordinates}) async {
      LatLng destination = coordinates;
      RouteModel route =
      await _googleMapsServices.getRouteByCoordinates(_center, destination);
      routeModel = route;
      _addLocationMarker(destination, routeModel.endAddress, routeModel.distance.text);
      _center = destination;
      destinationController.text = routeModel.endAddress;

      _createRoute(route.points);
      notifyListeners();
  }

 void _createRoute(String decodeRoute) {
    _poly = {};
    var uuid = new Uuid();
    String polyId = uuid.v1();
      poly.add(Polyline(
          polylineId: PolylineId(polyId),
          width: 12,
          color: Primary,
          onTap: () {},
          points: _convertToLatLong(_decodePoly(decodeRoute))));
          notifyListeners();
  }

List<LatLng> _convertToLatLong(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  Future<Uint8List> getMarker(BuildContext context) async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("images/car.png");
    return byteData.buffer.asUint8List();
  }    



}