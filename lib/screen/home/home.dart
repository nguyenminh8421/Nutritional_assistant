import 'package:demo_1/database/database_helper.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/import_food/breakfast.dart';
import 'package:demo_1/screen/import_food/dinner.dart';
import 'package:demo_1/screen/import_food/drink.dart';
import 'package:demo_1/screen/import_food/extra.dart';
import 'package:demo_1/screen/import_food/lunch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'tab_1.dart';
import 'tab_2.dart';
import 'tab_3.dart';
import '../import_food/breakfast.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxInt _selectedIndex = 0.obs;
  final UsersDatabaseHelper databaseHelper = UsersDatabaseHelper();


  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  final List<Widget> _tabScreens = [
    Tab1Screen(),
    Tab2Screen(),
    Tab3Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        leading: Image.asset(
          'assets/sticker/guy.png',
          width: 40,
          height: 40,
        ),
        title: FutureBuilder<String?>(
          future: databaseHelper.getUserName(),
          builder: (context, snapshot) {
            String userName = snapshot.data ?? ' ';
            return Row(
              children: [
                Text(
                  "Xin chào, $userName",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(width: 20),
              ],
            );
          },
        ),
      ),
      body: BackgroundWidget(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _selectedIndex.value = index;
          },
          children: _tabScreens,
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
            currentIndex: _selectedIndex.value,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: "Tổng Quan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list, size: 30),
                label: "Nhật Ký",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: "Cá Nhân",
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 1,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOptionButton(
                          Icons.local_cafe, "Bữa sáng", Colors.blue, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Breakfast()),
                        );
                      }),
                      SizedBox(height: 8),
                      _buildOptionButton(
                          Icons.lunch_dining, "Bữa trưa", Colors.green, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Lunch()),
                        );
                      }),
                      SizedBox(height: 8),
                      _buildOptionButton(
                          Icons.local_dining, "Bữa tối", Colors.orange, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dinner()),
                        );
                      }),
                      SizedBox(height: 8),
                      _buildOptionButton(
                          Icons.fastfood, "Bữa phụ", Colors.red, () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Extral()),
                        );
                      }),
                      SizedBox(height: 8),
                      _buildOptionButton(Icons.local_drink, "Đồ uống", Colors.pink,
                          () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Drink()),
                        );
                      
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildOptionButton(
      IconData icon, String label, Color backgroundColor, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
