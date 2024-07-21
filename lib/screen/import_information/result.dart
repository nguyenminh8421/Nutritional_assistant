import 'package:demo_1/screen/import_information/activity.dart';
import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/controller/user_controller.dart';
import 'package:get/get.dart';

class BMIResultPage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final double bmi;
  final int age;
  final String gender;

  BMIResultPage({required this.bmi, required this.age, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Image(
                    image: AssetImage(
                      userController.gender.value == 'Male'
                          ? 'assets/sticker/guy_${_getBMIImage(bmi)}.png'
                          : 'assets/sticker/girl_${_getBMIImage(bmi)}.png',
                    ),
                    height: 150,
                  )),
              SizedBox(height: 20),
              Text(
                'Tên : ${userController.userName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tuổi: $age',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'BMI: ${bmi.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Thêm padding ngang nếu cần
                child: Text(
                  _bmiResultText(bmi),
                  textAlign: TextAlign.center, // Căn giữa văn bản
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _bmiResultColor(bmi)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                     context,
                    MaterialPageRoute(builder: (context) =>  Activity()),
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

  String _bmiResultText(double bmi) {
    if (bmi < 18.5) {
      return 'Bạn đang rất gầy, cần tăng cân ngay lập tức';
    } else if (bmi >= 18.5 && bmi < 22.9) {
      return 'Tuyệt vời, bạn có chỉ số hoàn hảo';
    } else if (bmi >= 22.9 && bmi < 24.9) {
      return 'Cân nặng của bạn có hơi cao hơn tiêu chuẩn';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'Có vẻ như bạn đang béo phì, bạn nên giảm cân';
    } else if (bmi >= 29.9 && bmi < 39.9) {
      return 'Bạn đang quá nặng cân, hãy giảm cân ngay lập tức';
    } else {
      return 'Giảm cân ngay lập tức nếu bạn muốn sống tiếp';
    }
  }

  Color _bmiResultColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 22.9) {
      return Colors.green;
    } else if (bmi >= 22.9 && bmi < 24.9) {
      return Color.fromARGB(255, 153, 153, 7);
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return Colors.orange;
    } else if (bmi >= 29.9 && bmi < 39.9) {
      return Colors.red;
    } else {
      return Color.fromARGB(255, 119, 14, 6);
    }
  }   

  String _getBMIImage(double bmi) {
    if (bmi < 18.5) {
      return 'bad';
    } else if (bmi >= 18.5 && bmi < 22.9) {
      return 'normal';
    } else if (bmi >= 22.9 && bmi < 29.9) {
      return 'bad';
    } else {
      return 'sobad';
    }
  }
}
