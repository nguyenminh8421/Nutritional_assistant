import 'package:demo_1/controller/breakfast_controller.dart';
import 'package:demo_1/controller/extral_controller.dart';
import 'package:demo_1/controller/lunch_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/import_food/extral_import.dart';
import 'package:demo_1/screen/import_food/lunch_import.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_1/controller/food_controller.dart';

class Extral extends StatelessWidget {
  final FoodController foodController = Get.put(FoodController());
  final ExtralController extralController = Get.put(ExtralController());

  @override
  Widget build(BuildContext context) {
    extralController.fetchTodayExtralId();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Buổi Phụ'),
      ),
      body: BackgroundWidget(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        foodController.searchQuery.value = value;
                        foodController.filterFoods();
                      },
                      decoration: InputDecoration(
                        hintText: 'Tìm món ăn...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
              //Remove the Wrap widget
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Wrap(
                  spacing: 1,
                  runSpacing: 1.5,
                  children: ['Cơm', 'Bún', 'Phở', 'Canh', 'Bánh', 'Trứng', 'Mì', 'Cá', 'Thịt', 'Chè', 'Sữa', 'Hoa quả']
                      .map((type) => Obx(() {
                            bool isSelected = foodController.selectedType.value == type;
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? Colors.orange : Color.fromARGB(255, 157, 238, 87),
                                minimumSize: Size(5, 5),
                                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {                           foodController.toggleSelectedType(type);
                              },
                              child: Text(
                                type,
                                style: TextStyle(color: Colors.black, fontSize: 15.0),
                              ),
                            );
                          }))
                      .toList(),
                ),
              ),
            Expanded(
              child: Obx(() {
                if (foodController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                // Filter foods to only include "Đồ uống"
                //final filteredFoods = foodController.foods.where((food) => food['type'] == 'Đồ uống').toList();
                return ListView.builder(
                  itemCount: foodController.foods.length,
                  itemBuilder: (context, index) {
                    final food = foodController.foods[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(food['name']),
                          onTap: () {
                            // Điều hướng đến trang chi tiết món ăn với tên món ăn hoặc id
                            Get.to(ExtralImport(), arguments: food);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
