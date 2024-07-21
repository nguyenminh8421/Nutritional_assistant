import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  var quantity = 1.0.obs;
  var totalCalories = 0.0.obs;

  void updateCalories(double caloriesPerUnit) {
    totalCalories.value = quantity.value * caloriesPerUnit;
  }

  void setQuantity(double newQuantity) {
    quantity.value = newQuantity;
    updateCalories(Get.arguments['calo']);
  }

  void increment() {
    quantity.value++;
    updateCalories(Get.arguments['calo']);
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
      updateCalories(Get.arguments['calo']);
    }
  }

  @override
  void onClose() {
    // Reset controller when closing
    quantity.value = 1.0;
    totalCalories.value = 0.0;
    super.onClose();
  }
}
