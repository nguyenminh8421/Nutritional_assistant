import 'package:demo_1/controller/user_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/home/home.dart';
import 'package:demo_1/screen/import_information/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/goal_controller.dart';

class Choice2 extends StatelessWidget {
  final GoalController goalController = Get.find<GoalController>();
  final UserController userController = Get.find<UserController>();


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
                      'Bạn chọn mức tăng/giảm cân?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                   Text(
                      '(Không quan tâm nếu bạn chọn giữ cân)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0,),
                    ),
                    SizedBox(height: 20.0),
                    OptionSelector(goalController: goalController),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  final selectedGoalLevelText = Get.find<OptionSelectorController2>().selectedGoalLevelText;
        
                  if (selectedGoalLevelText != null) {
                    goalController.saveGoalLevel(selectedGoalLevelText);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BMRPage()),
                  );
                  } else {
                    print('Please select your activity level.');
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

class OptionSelectorController2 extends GetxController {
  var selectedIndex = 0.obs; // Mặc định chọn vị trí 0 (Mức tăng/giảm cân chậm)

  final List<Color> colors = [Colors.orange, Colors.green, Colors.blue];
  final List<String> texts = ['Mức tăng/giảm cân chậm = 0.5kg/tuần', 'Mức tăng/giảm cân vừa = 1kg/tuần', 'Mức tăng/giảm cân nhanh = 1.5kg/tuần' ];


  String? selectedGoalLevelText;
    @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 0;
    selectedGoalLevelText = texts[0];
  }

  void selectOption(int index) {
    selectedIndex.value = index;
    selectedGoalLevelText = texts[index];
  }
}

class OptionSelector extends StatelessWidget {
  final OptionSelectorController2 controller = Get.put(OptionSelectorController2());
  final GoalController goalController;

  OptionSelector({required this.goalController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () {
            controller.selectOption(index);
            // Lưu giá trị tương ứng vào GoalController
          },
          child: Obx(() => Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index ? controller.colors[index] : Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey)
            ),
            child: Center(
              child: Text(
                controller.texts[index],
                style: TextStyle(
                  fontSize: 14.0,
                  color: controller.selectedIndex.value == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          )),
        );
      }),
    );
  }
}

