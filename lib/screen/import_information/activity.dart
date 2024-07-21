import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/import_information/choice2.dart';
import 'package:demo_1/screen/intro/intro1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/user_controller.dart';
import 'package:demo_1/screen/import_information/choice1.dart';

class Activity extends StatelessWidget {
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
                      'Mức độ hoạt động của bạn là?',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    OptionSelector(),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  final selectedActivityText = Get.find<OptionSelectorController>().selectedActivityText;
        
                  if (selectedActivityText != null) {
                    userController.saveActivity(selectedActivityText);
                    userController.saveUserToDatabase();
        
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Choice1()),
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

class OptionSelectorController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Color> colors = [Colors.green, Colors.blue, Colors.green.shade400, Colors.orange, Colors.red];
  final List<String> texts = ['Hoạt động rất ít', 'Hoạt động nhẹ nhàng', 'Hoạt động vừa phải', 'Hoạt động nhiều', 'Hoạt động cực nhiều'];

  String? selectedActivityText;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 0;
    selectedActivityText = texts[0];
  }

  void selectOption(int index) {
    selectedIndex.value = index;
    selectedActivityText = texts[index];
  }
}

class OptionSelector extends StatelessWidget {
  final OptionSelectorController controller = Get.put(OptionSelectorController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            controller.selectOption(index);
          },
          child: Obx(() {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: controller.selectedIndex.value == index ? controller.colors[index] : Colors.grey[200],
                borderRadius: BorderRadius.circular(5.0),
               border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  controller.texts[index],
                  style: TextStyle(
                    color: controller.selectedIndex.value == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
