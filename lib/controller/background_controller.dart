import 'package:get/get.dart';

class BackgroundController extends GetxController {
  var backgroundImage = 'assets/light.png'.obs;

  void changeBackground(String newBackground) {
    backgroundImage.value = newBackground;
  }
}
