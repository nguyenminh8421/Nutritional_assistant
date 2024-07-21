import 'package:demo_1/controller/user_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/goal_controller.dart';
import 'package:demo_1/database/database_helper.dart';

import 'choice2.dart';

class Choice1 extends StatelessWidget {
  final GoalController goalController = Get.put(GoalController());
  final UserController userController = Get.find<UserController>();

  String getBmiStatus(double bmi) {
    if (bmi < 18.5) {
      return '"Tăng cân"';
    } else if (bmi < 22.9) {
      return '"Giữ cân"';
    } else {
      return '"Giảm cân"';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Chúng tôi khuyên bạn nên ${getBmiStatus(userController.bmi.value)}', // Sử dụng giá trị cố định 22.0 làm ví dụ
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    OptionSelector(goalController: goalController),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  int? userId = await UsersDatabaseHelper().getUserId();
                  final selectedGoalText = Get.find<OptionSelectorController1>().selectedGoalText;
                  if (userId != null && selectedGoalText != null) {
                    goalController.saveUserId(userId); 
                    goalController.saveGoal(selectedGoalText);
                    //goalController.saveGoal(goalController.goal.value)// Lưu userId vào goalcontroller
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Choice2()),
                    );
                  } else {
                    // Xử lý khi không tìm thấy userId
                    print('Không tìm thấy userId');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text(
                    'Tiếp Tục',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionSelectorController1 extends GetxController {
  var selectedIndex = 0.obs; // Mặc định chọn vị trí 0 (Tăng Cân)

  final List<Color> colors = [Colors.orange, Colors.green, Colors.blue];
  final List<String> texts = ['Tăng Cân', 'Giữ Cân', 'Giảm Cân'];

  @override
  String? selectedGoalText;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 0;
    selectedGoalText = texts[0];
  }

  void selectOption(int index) {
    selectedIndex.value = index;
    selectedGoalText = texts[index];
  }
}

class OptionSelector extends StatelessWidget {
  final OptionSelectorController1 controller = Get.put(OptionSelectorController1());
  final GoalController goalController;

  OptionSelector({required this.goalController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () {
            controller.selectOption(index);
          },
          child: Obx(() => Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == index
                      ? controller.colors[index]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey)
                ),
                child: Center(
                  child: Text(
                    controller.texts[index],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: controller.selectedIndex.value == index
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }
}
