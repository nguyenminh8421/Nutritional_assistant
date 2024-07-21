import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/user_controller.dart';
import 'package:demo_1/screen/intro/hello.dart';

class GenderImagePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height * 0.2;

    // Set default gender if not already set
    if (userController.gender.value.isEmpty) {
      userController.saveGender('Male');
    }

    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height1),
                Obx(() => ToggleButtons(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text('Nam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text('  Nữ ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ],
                      isSelected: [
                        userController.gender.value == 'Male',
                        userController.gender.value == 'Female',
                      ],
                      onPressed: (index) => userController.saveGender(index == 0 ? 'Male' : 'Female'),
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color.fromARGB(255, 165, 136, 136),
                      selectedColor: Theme.of(context).primaryColor,
                      fillColor: Colors.grey.shade300,
                    )),
                SizedBox(height: 20),
                Obx(() => Image.asset(
                      userController.gender.value == 'Male'
                          ? 'assets/sticker/guy.png'
                          : 'assets/sticker/girl.png',
                      height: 150,
                    )),
                SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    children: [
                      Text('Mình có thể gọi bạn là?', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      TextField(
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(border: OutlineInputBorder()),
                        onChanged: userController.saveUserName,
                      inputFormatters: [
                         LengthLimitingTextInputFormatter(10), 
                         ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Obx(() => Opacity(
                      opacity: userController.userName.value.length >= 2 ? 1.0 : 0.2,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.9,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                          onPressed: userController.userName.value.length >= 2
                              ? () {
                                  // Ensure gender is set before navigating
                                  if (userController.gender.value.isEmpty) {
                                    userController.saveGender('Male');
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GreetingPage()),
                                  );
                                }
                              : null,
                          child: Text('Tiếp tục', style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    )),
                  SizedBox(height: 170,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
