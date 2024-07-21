import 'dart:async';
import 'package:get/get.dart';
import 'package:demo_1/database/database_helper.dart';

class Tab1Controller extends GetxController {
  final UsersDatabaseHelper _databaseHelper = UsersDatabaseHelper();

  // Biến để lưu trữ các giá trị goals
  RxDouble goalCalo = RxDouble(0.0);
  RxDouble goalCarb = RxDouble(0.0);
  RxDouble goalProtein = RxDouble(0.0);
  RxDouble goalFat = RxDouble(0.0);

  // Biến để lưu trữ tổng calo
  RxDouble totalCalo = RxDouble(0.0);
  RxDouble totalCarb = RxDouble(0.0);
  RxDouble totalProtein = RxDouble(0.0);
  RxDouble totalFat = RxDouble(0.0);

  String today = DateTime.now().toString().split(' ')[0]; // Lấy ngày hiện tại

  Timer? _timer;

  var text1 = ''.obs;

  @override
  void onInit() {
    loadGoals();
    _startAutoUpdate();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Hàm để tính và cập nhật rate và text1
  void calculateRateAndText() {
    if (goalCalo.value != 0) {
      double rate = totalCalo.value / goalCalo.value;
      if (rate == 0) {
        text1.value = "Ăn gì đó đi bạn yêu ơii";
      } else if (rate > 0 && rate < 0.7) {
        text1.value = "Tiếp tục nào bạn ơi, giỏi lắm ";
      } else if (rate >= 0.7 && rate < 1) {
        text1.value = "Chú ý chú ý, bạn chỉ còn ${(goalCalo.value- totalCalo.value).toInt()} calo";
      } else if (rate >= 1) {
        text1.value = " Bạn ăn nhiều quá rồi\n định biến thành heo à";
      }
    }
  }

  void loadGoals() async {
    Map<String, dynamic>? latestGoal = await _databaseHelper.getGoals();
    if (latestGoal != null) {
      // Lấy giá trị goal_calo, goal_carb, goal_protein và goal_fat từ mục tiêu mới nhất
      goalCalo.value = latestGoal['goal_calo'] ?? 0.0;
      goalCarb.value = latestGoal['goal_carb'] ?? 0.0;
      goalProtein.value = latestGoal['goal_protein'] ?? 0.0;
      goalFat.value = latestGoal['goal_fat'] ?? 0.0;
    }
  }

  void loadTotalCalo() async {
    double calo = await _databaseHelper.getTotalCalo(today);
    totalCalo.value = calo;
    calculateRateAndText(); // Gọi hàm tính rate và cập nhật text1 khi load lại totalCalo
  }

  void loadTotalCarb() async {
    double carb = await _databaseHelper.getTotalCarb(today);
    totalCarb.value = carb;
  }

  void loadTotalProtein() async {
    double protein = await _databaseHelper.getTotalProtein(today);
    totalProtein.value = protein;
  }

  void loadTotalFat() async {
    double fat = await _databaseHelper.getTotalFat(today);
    totalFat.value = fat;
  }

  void _startAutoUpdate() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      loadTotalCalo();
      loadTotalCarb();
      loadTotalFat();
      loadTotalProtein();
    });
  }
}
