import 'package:demo_1/controller/user_controller.dart';
import 'package:demo_1/screen/import_information/BMI.dart';
import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GreetingPage extends StatelessWidget {
  final UserController userController = Get.find<UserController>(); // Lấy UserController

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Image(
                    image: AssetImage(
                      userController.gender.value == 'Male'
                          ? 'assets/sticker/guy_hello.png'
                          : 'assets/sticker/girl_hello.png',
                    ),
                    height: 200,
                  )),
              SizedBox(height: 30),
              Text('Xin chào bạn',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Obx(() => Text(
                    '${userController.userName.value}!, ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 10,),
              Text('Đầu tiên hãy tính chỉ số BMI của bạn', style: TextStyle(fontSize: 18),),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMICalculatorPage(),
                    ),
                  );
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
                    'Bắt Đầu',
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
