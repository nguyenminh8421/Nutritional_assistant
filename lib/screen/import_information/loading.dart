import 'package:demo_1/caculation/Caculation.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/user_controller.dart';
import 'package:demo_1/controller/goal_controller.dart';

class BMRPage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final GoalController goalController = Get.find<GoalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (userController.age.value == 0) {
              return Center(child: CircularProgressIndicator());
            } else {
              double weight = userController.weight.value;
              double height = userController.height.value;
              int age = userController.age.value;
              String gender = userController.gender.value;
              String activity = userController.activity.value;
              String goal = goalController.goal.value;
              String goalLevel = goalController.goalLevel.value;
              int user_id = goalController.userId.value;
              var goal_carb= 0.0;
              var goal_protein = 0.0;
              var goal_fat = 0.0;
        
              BMRCalculator bmrCalculator = BMRCalculator(weight, height, age, gender, activity, goal, goalLevel);
              double bmr = bmrCalculator.calculateBMR();
              goal_carb=bmr*0.55;
              goal_fat=bmr*0.25;
              goal_protein = bmr*0.2;
        
              goalController.saveGoalCalo(bmr);
              goalController.saveGoalCarb(goal_carb);
              goalController.saveGoalFat(goal_fat);
              goalController.saveGoalProtein(goal_protein);
        
              goalController.saveGoalToDatabase();
        
              Future.delayed(Duration(seconds: 3), () {
                Get.to(HomeScreen());
              });
        
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Đang tính toán, vui lòng chờ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
