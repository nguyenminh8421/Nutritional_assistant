import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result.dart';
import 'package:demo_1/controller/user_controller.dart';

class BMICalculatorPage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  final _formKey = GlobalKey<FormState>();
  int age = 0;
  double weight = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  alignment: Alignment.center,
                  child: const Text(
                    'Bạn hãy nhập các thông tin cơ thể để tính chỉ số BMI',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tuổi',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hãy nhập tuổi của bạn!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      age = int.parse(value!);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                            width: 2.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Cân nặng (kg)',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Hãy nhập cân nặng của bạn!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            weight = double.parse(value!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                            width: 2.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Chiều cao (cm)',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Hãy nhập chiều cao của bạn!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            height = double.parse(value!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      userController.saveAge(age); // Cập nhật age trong UserController
                      userController.saveHeight(height); // Cập nhật height trong UserController
                      userController.saveWeight(weight); // Cập nhật weight trong UserController
                      double bmi = weight / ((height / 100) * (height / 100));
                      userController.bmi.value = bmi; // Cập nhật BMI trong UserController
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BMIResultPage(
                            bmi: userController.bmi.value,
                            age: age,
                            gender: userController.gender.value,
                          ),
                        ),
                      );
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
                      'Tính chỉ số BMI',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
