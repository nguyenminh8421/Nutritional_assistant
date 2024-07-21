import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/home/home.dart';
import 'package:demo_1/screen/import_food/breakfast.dart';
import 'package:demo_1/screen/import_food/dinner.dart';
import 'package:demo_1/screen/import_food/lunch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/tab1_controller.dart';
import 'package:demo_1/database/database_helper.dart';
 // Đường dẫn tới Break screen

class BuoiSang extends StatelessWidget {
  final Tab1Controller tab1controller = Get.find<Tab1Controller>();

  @override
  Widget build(BuildContext context) {
    double break_calo = tab1controller.goalCalo.value * 0.25;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quay lại'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(HomeScreen());
          },
        ),
      ),
      body: BackgroundWidget(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: UsersDatabaseHelper().filterFoodsByTypeAndCalories(["Bún", "Phở", "Bánh"], break_calo),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No foods found'));
            } else {
              List<Map<String, dynamic>> foods = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/sticker/guy_2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hiện tại là buổi sáng',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Bạn nên ăn khoảng ${break_calo.toInt()} calo',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Đây là các món ăn tớ gợi ý cho cậu',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        var food = foods[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(Breakfast()); // Điều hướng tới Break screen khi nhấn vào món ăn
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food['name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('Calories: ${food['calo']}'),
                                // Thêm các thông tin khác của món ăn tại đây
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}




class BuoiTrua extends StatelessWidget {
  final Tab1Controller tab1controller = Get.find<Tab1Controller>();

  @override
  Widget build(BuildContext context) {
    double lunch_Calo = tab1controller.goalCalo.value * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quay lại'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(HomeScreen());
            // Để quay lại màn hình trước đó
          },
        ),
      ),
      body: BackgroundWidget(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: UsersDatabaseHelper().filterFoodsByTypeAndCalories(["Cơm", "Canh", "Cá","Thịt"], lunch_Calo),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No foods found'));
            } else {
              List<Map<String, dynamic>> foods = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/sticker/guy_2.png'), // Đường dẫn đến hình ảnh của bạn
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hiện tại là buổi trưa',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Bạn nên ăn khoảng ${lunch_Calo.toInt()}calo',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                          
                        ),
                        SizedBox(height: 20),
                        Text('Cậu nên ăn đầy đủ Cơm, Canh, Thịt, Cá. Như các món dưới này nè',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        var food = foods[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(Lunch()); // Điều hướng tới Break screen khi nhấn vào món ăn
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food['name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('Calories: ${food['calo']}'),
                                // Thêm các thông tin khác của món ăn tại đây
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class BuoiToi extends StatelessWidget {
  final Tab1Controller tab1controller = Get.find<Tab1Controller>();

  @override
  Widget build(BuildContext context) {
    double dinner_calo = tab1controller.goalCalo.value - tab1controller.totalCalo.value;

    // Lấy giá trị của các biến từ Tab1Controller
    double goalCarb = tab1controller.goalCarb.value;
    double totalCarb = tab1controller.totalCarb.value;
    double goalProtein = tab1controller.goalProtein.value;
    double totalProtein = tab1controller.totalProtein.value;
    double goalFat = tab1controller.goalFat.value;
    double totalFat = tab1controller.totalFat.value;

    // Tính tỉ lệ
    double ratioCarb = totalCarb / goalCarb;
    double ratioProtein = totalProtein / goalProtein;
    double ratioFat = totalFat / goalFat;

    // Xác định tỉ lệ bé nhất và loại chất dinh dưỡng
    double minRatio = ratioCarb;
    List<String> types = ["Cơm", "Bún","Phở","Bánh"]; // Mặc định nếu minRatio = ratioCarb

    if (ratioProtein < minRatio) {
      minRatio = ratioProtein;
      types = ["Thịt", "Cá","Trứng"];
    }

    if (ratioFat < minRatio) {
      minRatio = ratioFat;
      types = ["Sữa", "Canh","Trứng","Bánh"];
    }

    String message = "Bạn cần nạp thêm thực phẩm giàu Tinh bột, tớ chọn cho nè:";
    if (minRatio == ratioProtein) {
      message = "Bạn cần nạp thêm thực phẩm giàu Protein, tớ chọn cho nè:";
    } else if (minRatio == ratioFat) {
      message = "Bạn cần nạp thêm thực phẩm giàu Chất béo, tớ chọn cho nè:";
    }
     if (dinner_calo < 50) {
      message = "Hôm nay bạn nạp quá nhiều rồi, ăn hoa quả nhé";
      types = ["Hoa quả"];
      dinner_calo = 100;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quay lại'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(HomeScreen());
          },
        ),
      ),
      body: BackgroundWidget(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: UsersDatabaseHelper().filterFoodsByTypeAndCalories(types, dinner_calo),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No foods found'));
            } else {
              List<Map<String, dynamic>> foods = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/sticker/guy_2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Buổi tối vui vẻ',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Bạn cần nạp ${dinner_calo.toInt()} calo \nđể hoàn mục tiêu hôm nay ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          message,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        var food = foods[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(Dinner()); // Điều hướng tới Break screen khi nhấn vào món ăn
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food['name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('Calories: ${food['calo']}'),
                                // Thêm các thông tin khác của món ăn tại đây
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
