import 'package:demo_1/controller/step_controller.dart';
import 'package:demo_1/controller/tab1_controller.dart';
import 'package:demo_1/database/database_helper.dart';
import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/home/home.dart';
import 'package:demo_1/screen/home/recommend.dart';
import 'package:demo_1/screen/home/stepcount.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

class Tab1Screen extends StatelessWidget {
      final Tab1Controller tab1controller = Get.put(Tab1Controller());
      final UsersDatabaseHelper db = UsersDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String period;
    double goal_calo = tab1controller.goalCalo.value;

    
    // Xác định buổi
    if (now.hour >= 5 && now.hour < 10) {
      period = "sáng";
    } else if (now.hour >= 10 && now.hour < 15) {
      period = "trưa";
    } else if (now.hour >= 15 && now.hour < 22) {
      period = "tối";
    } else {
      period = "đêm";
    }
    
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundWidget(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  color: Colors.orange[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 50,
                                child: Center(
                                  child: Obx(() =>
                                     Text(
                                      '${tab1controller.totalCalo.value.toInt()} calo',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Đã nạp ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                           Obx(() =>
                             ProgressCircle(current:tab1controller.totalCalo.value, max:tab1controller.goalCalo.value > 0
                                      ? tab1controller.goalCalo.value
                                      : 1, ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 50,
                                child: Center(
                                  child: Obx(
                                    ()=> Text(
                                      '${tab1controller.goalCalo.value.toInt()} calo',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Cần nạp',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Chất Đạm',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(() =>
                               ProgressBar(current: tab1controller.totalProtein.value, max: tab1controller.goalProtein.value > 0
                                      ? tab1controller.goalProtein.value/4
                                      : 1,),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Tinh Bột',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(() =>
                                 ProgressBar(current: tab1controller.totalCarb.value, max: tab1controller.goalCarb.value > 0
                                      ? tab1controller.goalCarb.value/4
                                      : 1,),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Chất béo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(() =>
                                 ProgressBar(current: tab1controller.totalFat.value, max: tab1controller.goalFat.value > 0
                                      ? tab1controller.goalFat.value/9
                                      : 1,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 70, child: Image.asset('assets/sticker/guy_2.png'),),
                          
                          Obx(() => Text(tab1controller.text1.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 13, 6, 143)),)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
InkWell(
  onTap: () {
    // Code to navigate to the other page
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Recommend()),
                  );// Replace with your actual route name
  },
  child: Container(
    height: 190,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
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
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/sticker/guy_hello.png',
          height: 100,
        ),
        SizedBox(height: 10),
        Text(
          'Đã đến buổi $period rồi, bạn đã ăn gì chưa?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
),

              // Container(
              //   height: 210,
              //   margin: EdgeInsets.all(20),
              //   padding: EdgeInsets.all(15),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey.withOpacity(0.2)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.2),
              //         spreadRadius: 2,
              //         blurRadius: 7,
              //         offset: Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       Text(
              //         'Biểu đồ cân nặng',
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       WeightChart(),
              //     ],
              //   ),
              // ),
              InkWell(
                onTap: () {
    // Code to navigate to the other page
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>StepCount()),
                  );// Replace with your actual route name
  },
                child: Container(
                  height: 100,
                  width: 320,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
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
                  child: Center(
                    child: Text(
                      'Hãy xem hôm nay bạn đã đi \nbao nhiêu bước nhé',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                  ),
              ),
            ]
          ),
        ),
        
      ),
    );
  }
}

class ProgressCircle extends StatelessWidget {
  final double current;
  final double max;

  ProgressCircle({required this.current, required this.max});

  @override
  Widget build(BuildContext context) {
    double percentage = (current / max) * 100;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: current / max,
            strokeWidth: 5,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ],
    );
  }
}



class ProgressBar extends StatelessWidget {
  final double current;
  final double max;

  ProgressBar({required this.current, required this.max});

  @override
  Widget build(BuildContext context) {
    double percentage = min(current / max, 1.0);

    return Column(
      children: [
        SizedBox(height: 4),
        Container(
          width: 100,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Text(
          '${current.toStringAsFixed(0)}/${max.toStringAsFixed(0)}g',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}


class WeightChart extends StatelessWidget {
  final List<double> weightData = [60, 60.5, 61, 61, 62, 61.5, 62.5];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = ['Hai', 'Ba', 'Bốn', 'Năm', 'Sáu', 'Bảy', 'CN'];
                  return Text(days[value.toInt() % days.length]);
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 6,
          minY: 59,
          maxY: 64,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                weightData.length,
                (index) => FlSpot(index.toDouble(), weightData[index]),
              ),
              isCurved: true,
              barWidth: 4,
              belowBarData: BarAreaData(show: true, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
