import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Image.asset('assets/logo1.png',width: 130, height: 130,),

            const SizedBox(height: 20), 

            Text("BKalo", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),),

            SizedBox(height: 20),

            Text('Tính toán chỉ số BMI và nhận ngay lộ trình để có cuộc sống khỏe mạnh hơn!', style: TextStyle(fontSize: 18),)
          ],
        ),

      ), 
    );
  }
}
