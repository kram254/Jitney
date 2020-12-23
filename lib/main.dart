import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jitney/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:jitney/providers/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jitney/helpers/constants.dart';


void main () async{
WidgetsFlutterBinding.ensureInitialized();
SharedPreferences prefs = await SharedPreferences.getInstance();
LocationPermission permission = await Geolocator.checkPermission();
bool _isLocationEnabled = await Geolocator.isLocationServiceEnabled();

bool _hasLocationPermission = prefs.getBool(HAS_PERMISSION) ?? false;
//if has location_permission is null by default its going to be set to false
 _isLocationEnabled =prefs.getBool(LOCATION_ENABLED) ?? false;



if(!_isLocationEnabled){

  await Geolocator.openLocationSettings();

}else{
  if(!_hasLocationPermission){
  if(permission != LocationPermission.always){
  LocationPermission locationPermission = await Geolocator.requestPermission();

  if(Geolocator.requestPermission() == LocationPermission.always){
      await prefs .setBool(HAS_PERMISSION, true);
  }else {
    // TODO:: do something
  }
}
}
}

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.initialize())
  ],
  child: MaterialApp (
    debugShowCheckedModeBanner: false,
    title:"Jitney",
    home: HomeScreen()),
    ));
}