import 'package:demo_1/controller/step_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepCount extends StatelessWidget {
  final StepCountController controller = Get.put(StepCountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Thống kê hoạt động'),
      ),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 150, 
              child: Image.asset('assets/sticker/guy_2.png')),
              SizedBox(height: 16),
             
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Hôm nay bạn đã đi ',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    Obx(() => Text(
                          '${ controller.steps.value -146300 } bước',
                          style: TextStyle(fontSize: 24, color: Colors.blue),
                        )),
                  ],
                ),
              ),
             
              SizedBox(height: 16),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Quãng đường',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Obx(() => Text(
                                '${((controller.steps.value -146300)*0.7).toInt()} m',
                                style: TextStyle(fontSize: 20, color: Colors.green),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Calo tiêu thụ',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Obx(() => Text(
                                '${((controller.steps.value-146300)*0.05).toInt()}',
                                style: TextStyle(fontSize: 20, color: Colors.red),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ), 
        ),
      )
    );
  }
}