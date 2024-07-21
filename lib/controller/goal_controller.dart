import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:demo_1/database/food_database.dart';

class GoalController extends GetxController {
  var userId = 0.obs;
  var goal = ''.obs;
  var goalLevel = ''.obs;
  var goalCalo = 0.0.obs;
  var goalCarb = 0.0.obs;
  var goalProtein = 0.0.obs;
  var goalFat = 0.0.obs;
  var weight = 0.0.obs;

  final UsersDatabaseHelper _databaseHelper = UsersDatabaseHelper();

  void saveUserId(int id) {
    userId.value = id;
  }

  void saveGoal(String goalValue) {
    goal.value = goalValue;
  }

  void saveGoalLevel(String level) {
    goalLevel.value = level;
  }

  void saveGoalCalo(double calo) {
    goalCalo.value = calo;
  }

  void saveGoalCarb(double carb) {
    goalCarb.value = carb;
  }

  void saveGoalProtein(double protein) {
    goalProtein.value = protein;
  }

  void saveGoalFat(double fat) {
    goalFat.value = fat;
  }

  void saveWeight(double weightValue) {
    weight.value = weightValue;
  }
  Future<void> saveGoalToDatabase() async {
    await _databaseHelper.saveGoal(
      userId.value,
      goal.value,
      goalLevel.value,
      goalCalo.value,
      goalCarb.value,
      goalProtein.value,
      goalFat.value,
      weight.value,
    );
  }


  void loadGoal() async {
    Map<String, dynamic>? goalData = await _databaseHelper.getGoal(userId.value);
    if (goalData != null) {
      goal.value = goalData['goal'];
      goalLevel.value = goalData['goal_level'];
      goalCalo.value = goalData['goal_calo'];
      goalCarb.value = goalData['goal_carb'];
      goalProtein.value = goalData['goal_protein'];
      goalFat.value = goalData['goal_fat'];
      weight.value = goalData['weight'];
    }
  }
}
