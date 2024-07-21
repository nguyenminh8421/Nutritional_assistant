import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/intro/intro1.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05), // 10% của chiều rộng màn hình
                    alignment: Alignment.center,
                    child: const Text(
                      'Tính toán chỉ số BMI và nhận ngay lộ trình để có cuộc sống khỏe mạnh hơn!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(221, 6, 34, 51)),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.9, // 80% của chiều cao màn hình
                left: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Intro1()),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
