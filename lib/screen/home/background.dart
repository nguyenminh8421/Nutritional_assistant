import 'package:demo_1/controller/background_controller.dart';
import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundSettings extends StatelessWidget {
  final BackgroundController _backgroundController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Hình Nền'),
        backgroundColor: Colors.orange,
      ),
      body: BackgroundWidget(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildBackgroundOption('Trắng', 'assets/white.png'),
            _buildBackgroundOption('Sáng', 'assets/light.png'),
            _buildBackgroundOption('Cam', 'assets/orange.png'),
            _buildBackgroundOption('Tím', 'assets/violet.png'),
            _buildBackgroundOption('Đêm', 'assets/night.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundOption(String title, String assetPath) {
    return GestureDetector(
      onTap: () {
        _backgroundController.changeBackground(assetPath);
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
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
            Icon(Icons.image, size: 30, color: Colors.orange),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
