import 'package:jitney/helpers/constants.dart';
import 'package:jitney/models/user.dart';

class UserServices{
  String collection = "drivers";

  void createUser({
  String id,
  String name,
  String email,
  String phone,
  int trips = 0,
  double rating = 0,
  Map position}) {
    firebaseFiretore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
      "trips": trips,
      "rating": rating,
      "position": position
    });
  }

  void updateUserData(Map<String, dynamic> values){
    firebaseFiretore.collection(collection).doc(values['id']).update(values);
  }

  Future<UserModel> getUserById(String id) => firebaseFiretore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

}