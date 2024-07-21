
import 'package:demo_1/screen/home/recommend_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Recommend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sử dụng WidgetsBinding để đảm bảo rằng việc điều hướng diễn ra sau khi widget được xây dựng.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime now = DateTime.now();
      int hour = now.hour;

      if (hour >= 5 && hour < 10) {
        Get.offAll(() => BuoiSang());
      } else if (hour >= 10 && hour < 15) {
        Get.offAll(() => BuoiTrua());
      } else {
        Get.offAll(() => BuoiToi());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Thời Gian Trong Ngày'),
      ),
      body: Center(
        child: Text('Đang kiểm tra thời gian...'),
      ),
    );
  }
}
