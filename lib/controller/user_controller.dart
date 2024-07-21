import 'dart:ffi';

import 'package:get/get.dart';
import 'package:demo_1/database/database_helper.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var gender = ''.obs;
  var age = 0.obs;
  var activity = ''.obs;
  var bmi = 0.0.obs;
  var height = 0.0.obs;
  var weight = 0.0.obs;
  final UsersDatabaseHelper _databaseHelper = UsersDatabaseHelper();

  void saveUserName(String name) {
    userName.value = name;
  }

  void saveGender(String userGender) {
    gender.value = userGender;
  }

  void saveAge(int userAge) {
    age.value = userAge;
  }

  void saveActivity(String userActivity) {
    activity.value = userActivity;
  }
    void saveBMI(double userBMI) {
    bmi.value = userBMI;
  }
      void saveHeight(double userHeight) {
    height.value = userHeight;
  }
        void saveWeight(double userWeight) {
    weight.value = userWeight;
  }
  
  

  Future<void> saveUserToDatabase() async {
    await _databaseHelper.saveUser(
      userName.value,
      gender.value,
      age.value,
      activity.value,
      bmi.value,
      height.value,
      weight.value,
    );
  }
}
