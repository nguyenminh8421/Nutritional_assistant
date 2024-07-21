import 'package:demo_1/controller/tab3_controller.dart';
import 'package:demo_1/screen/home/background.dart';
import 'package:demo_1/screen/home/tab_2.dart';
import 'package:demo_1/screen/import_food/addFood.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/home/goal.dart';
import 'package:demo_1/screen/home/personal.dart';
import 'package:demo_1/screen/home/stepcount.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Tab3Screen extends StatelessWidget {
  final DatabaseController _controller = Get.put(DatabaseController());
  final UsersDatabaseHelper databaseHelper = UsersDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Hồ sơ và Cài đặt', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 30),
                    ),
                    SizedBox(width: 10),
                    FutureBuilder<String?>(
                      future: databaseHelper.getUserName(),
                      builder: (context, snapshot) {
                        String userName = snapshot.data ?? ' ';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$userName', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        );
                      }
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Personal()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 30),
                          SizedBox(width: 10),
                          Text('Thông tin cá nhân', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFoodPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.add_circle, size: 30),
                          SizedBox(width: 10),
                          Text('Thêm món ăn', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
                            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BackgroundSettings()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.picture_in_picture, size: 30),
                          SizedBox(width: 10),
                          Text('Thay đổi giao diện', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              
              
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Xác nhận'),
                        content: Text('Bạn có muốn xóa toàn bộ thông tin không?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Không'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Logic để xóa thông tin
                              _controller.deleteAllData();
                            },
                            child: Text('Có'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.delete, size: 30, color: Colors.red),
                          SizedBox(width: 10),
                          Text('Xóa thông tin cá nhân', style: TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 120,),
            ],
          ),
        ),
      ),
    );
  }
}