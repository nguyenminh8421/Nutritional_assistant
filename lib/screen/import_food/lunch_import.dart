import 'package:demo_1/controller/fooddetail_controller.dart';
import 'package:demo_1/controller/lunch_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/database/database_helper.dart';
import 'package:demo_1/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class LunchImport extends StatelessWidget {
  final FoodDetailController controller = Get.put(FoodDetailController());
  final LunchController lunchController = Get.find<LunchController>();
  final UsersDatabaseHelper db = UsersDatabaseHelper();

  String getImagePath(String type) {
    switch (type) {
      case 'Cơm':
        return 'assets/food/com.png';
      case 'Bún':
        return 'assets/food/bun.png';
      case 'Phở':
        return 'assets/food/pho.png';
      case 'Canh':
        return 'assets/food/canh.png';
      case 'Bánh':
        return 'assets/food/banh.png';
      case 'Chè':
        return 'assets/food/che.png';
      case 'Mì':
        return 'assets/food/mi.png';
      case 'Cá':
        return 'assets/food/ca.png';
      case 'Thịt':
        return 'assets/food/thit.png';
      case 'Trứng':
        return 'assets/food/trung.png';
      case 'Sữa':
        return 'assets/food/sua.png';
      case 'Hoa quả':
        return 'assets/food/hoaqua.png';
      default:
        return 'assets/food/conlai.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final food = Get.arguments;
    controller.updateCalories(food['calo'].toDouble());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Text('Nhập số lượng món ăn'),
      ),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 360,
                child: Image.asset(
                  getImagePath(food['type']),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1 ${food['name_word']} ${food['name']}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Trọng lượng: ${food['size']}gram,  Năng lượng: ${food['calo']}calo'),
              Text('Protein: ${food['protein']}gram,  Chất béo ${food['fat']}gram,  Carb:${food['carb']}gram,'),
              SizedBox(height: 10),
              Obx(() => Text(
                'Lượng calo phục vụ: ${controller.totalCalories.value.toStringAsFixed(2)} calo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Số lượng món ăn',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.quantity.value = double.parse(value);
                      controller.updateCalories(food['calo'].toDouble());
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tỷ lệ các chất dinh dưỡng:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: food['carb'].toDouble(),
                              title: '${(food['carb'] * 100 / (food['fat'] + food['protein'] + food['carb'])).toStringAsFixed(1)}%',
                              color: Colors.blue,
                              radius: 50,
                            ),
                            PieChartSectionData(
                              value: food['protein'].toDouble(),
                              title: '${(food['protein'] * 100 / (food['fat'] + food['protein'] + food['carb'])).toStringAsFixed(1)}%',
                              color: Colors.green,
                              radius: 50,
                            ),
                            PieChartSectionData(
                              value: food['fat'].toDouble(),
                              title: '${(food['fat'] * 100 / (food['fat'] + food['protein'] + food['carb'])).toStringAsFixed(1)}%',
                              color: Colors.red,
                              radius: 50,
                            ),
                          ],
                          sectionsSpace: 0,
                          centerSpaceRadius: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem('Carb', Colors.blue),
                          _buildLegendItem('Protein', Colors.green),
                          _buildLegendItem('Fat', Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add a SizedBox to provide some space before the buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      int? mealId = lunchController.lunchId.value;
                      int foodId = food['id'];
                      double quantity = controller.quantity.value;
        
                      if (mealId != null && foodId != null && quantity > 0) {
                        int insertedId = await UsersDatabaseHelper().insertMealFood(mealId, foodId, quantity);
                        if (insertedId != null && insertedId > 0) {
                          print('Thêm dữ liệu vào meal_food thành công, ID: $insertedId');
                          await db.updateMealTotals( mealId);
                          print('Thêm dữ liệu vào meal_food thành công, ');
                        } else {
                          print('Thêm dữ liệu vào meal_food thất bại');
                        }
                      } else {
                        print('Thông tin mealId, foodId hoặc quantity không hợp lệ');
                      }
        
                      Get.delete<FoodDetailController>();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        ' Tiếp tục thêm',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () async{
                      int? mealId = lunchController.lunchId.value;
                      int foodId = food['id'];
                      double quantity = controller.quantity.value;
        
                      if (mealId != null && foodId != null && quantity > 0) {
                        int insertedId = await UsersDatabaseHelper().insertMealFood(mealId, foodId, quantity);
                        if (insertedId != null && insertedId > 0) {
                          print('Thêm dữ liệu vào meal_food thành công, ID: $insertedId');
                          await db.updateMealTotals( mealId);
                          print('Thêm dữ liệu vào meal_food thành công, ');
                        } else {
                          print('Thêm dữ liệu vào meal_food thất bại');
                        }
                      } else {
                        print('Thông tin mealId, foodId hoặc quantity không hợp lệ');
                      }
        
                      Get.delete<FoodDetailController>();
                      Get.to(() => HomeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        ' Xong',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
