import 'package:demo_1/controller/background_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final BackgroundController _backgroundController = Get.put(BackgroundController());

  BackgroundWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundController.backgroundImage.value),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      );
    });
  }
}
