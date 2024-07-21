import 'package:demo_1/controller/tab1_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Tab2Screen extends StatelessWidget {
  final UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
  final Tab1Controller _tab1controller = Get.find<Tab1Controller>();

  Future<double> getTotalCaloriesByDate(String date) async {
    // Đây là hàm giả sử bạn đã cung cấp để lấy tổng calo của ngày
    return await dbHelper.getTotalCaloriesByDate(date);
  }

  String getRelativeDateString(DateTime date) {
    final now = DateTime.now();
    final differenceInDays = now.difference(date).inDays;

    switch (differenceInDays) {
      case 0:
        return "Hôm nay";
      case 1:
        return "Hôm qua";
      default:
        return "$differenceInDays ngày trước";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nhật ký ăn uống',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              DateTime date = DateTime.now().subtract(Duration(days: index));
              String dateString = date.toIso8601String().split('T')[0];
              String relativeDateString = getRelativeDateString(date);
              return FutureBuilder<double>(
                future: getTotalCaloriesByDate(dateString),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
          
                  double totalCalories = snapshot.data ?? 0.0;
          
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealsHistoryPage(date: dateString),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            relativeDateString,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Calo: ${totalCalories.toInt()} / ${_tab1controller.goalCalo.value.toInt()}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      
    );
  }
}

class MealsHistoryPage extends StatelessWidget {
  final String date;
  final UsersDatabaseHelper dbHelper = UsersDatabaseHelper();

  MealsHistoryPage({required this.date});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Nhật ký bữa ăn'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Sáng'),
              Tab(text: 'Trưa'),
              Tab(text: 'Tối'),
              Tab(text: 'Phụ'),
              Tab(text: 'Đồ uống'),
            ],
          ),
        ),
        body: BackgroundWidget(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
 
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    MealTab(mealType: 'sáng', date: date),
                    MealTab(mealType: 'trưa', date: date),
                    MealTab(mealType: 'chiều', date: date),
                    MealTab(mealType: 'phụ', date: date),
                    MealTab(mealType: 'uống', date: date),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MealTab extends StatelessWidget {
  final String mealType;
  final String date;
  final UsersDatabaseHelper dbHelper = UsersDatabaseHelper();

  MealTab({required this.mealType, required this.date});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getMealsWithFoodsByDate(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No meals found for $date.'));
        }

        List<Map<String, dynamic>> meals = snapshot.data!
            .where((meal) => meal['meal_type'] == mealType)
            .toList();

        if (meals.isEmpty) {
          return Center(child: Text('No $mealType meals found for $date.'));
        }

        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            var meal = meals[index];
            var foods = meal['foods'] as List<Map<String, dynamic>>;

            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...foods.map((food) {
                    double totalCalories = food['amount'] * food['calo'];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(food['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Số lượng: ${food['amount']} phần'),
                        trailing: Text('Calo: ${totalCalories.toStringAsFixed(2)}', style: TextStyle(fontSize: 14)),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

