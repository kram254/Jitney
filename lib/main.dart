import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:jitney/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:jitney/providers/app.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:jitney/helpers/constants.dart';


void main () async{
WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider.value(value: AppProvider.initialize())
  ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.yellow,
        ),
        title: "J!tney",
        home: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("check if any error occured")],
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeScreen(title: 'J!tney');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );
  }

/*** 
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

  // ignore: unrelated_type_equality_checks
  if(Geolocator.requestPermission() == LocationPermission.always){
      await prefs .setBool(HAS_PERMISSION, true);
  }else {
    // TODO:: do something
  }
}
}
}

  runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider.value(value: AppProvider.initialize())
  ],
  child: MaterialApp (
    debugShowCheckedModeBanner: false,
    title:"Jitney",
    home: HomeScreen()),
    ));

    */
}