import 'package:demo_1/database/database_helper.dart';
import 'package:demo_1/screen/home/home.dart';
import 'package:demo_1/screen/intro/intro.dart';
import 'package:demo_1/database/food_database.dart'; // Import UsersDatabaseHelper
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/database/notification_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


void main() async{
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkUserExistsAndCreateMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); 
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
          
           if (snapshot.data == true) {
              print('User exists'); // Thêm log
              return HomeScreen(); // Nếu có bất kỳ user nào tồn tại
            } else {
              print('No user exists'); // Thêm log
              return Home(); // Nếu không có user nào tồn tại
            }
          }
        },
      ),
    );
  }

  Future<bool> checkUserExistsAndCreateMeals() async {
    UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
    await dbHelper.checkAndCreateMealsForToday(); // Gọi hàm kiểm tra và tạo meals cho ngày hiện tại
    return await dbHelper.userExists();
  }
}