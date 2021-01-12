<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

const GOOGLE_MAPS_API_KEY = "AIzaSyAoFnk3L-KTyNpSzidtGzACzdplLv-jkPM";

// firebase
final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
=======
 const HAS_PERMISSION = "has_permission";// we can call this constant anytime we need it
 const LOCATION_ENABLED = "location_enabled";
 const GOOGLE_MAPS_API_KEY = "AIzaSyAoFnk3L-KTyNpSzidtGzACzdplLv-jkPM";
>>>>>>> 119a6338cee98f55821da4eccfafc9d81f48c6ba
