import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

class StepCountController extends GetxController {
  var steps = 0.obs;
  var date = DateTime.now().toIso8601String().split('T')[0];
  final UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
  late Stream<StepCount> _stepCountStream;
  String currentDate = DateTime.now().toIso8601String().split('T')[0];

  @override
  void onInit() {
    super.onInit();
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount);
    fetchStepCount();
  }

  void onStepCount(StepCount event) {
    // Kiểm tra xem ngày có thay đổi không
    String newDate = DateTime.now().toIso8601String().split('T')[0];
    if (newDate != currentDate) {
      // Lưu số bước của ngày cũ vào cơ sở dữ liệu
      //saveStepsForOldDate(currentDate, steps.value);
      // Đặt lại bước về 0 cho ngày mới
      steps.value = 0;
      currentDate = newDate;
    }
    updateStepCount(event.steps);
  }

  void fetchStepCount() async {
    var stepCount = await dbHelper.getStepCount(date);
    if (stepCount != null) {
      steps.value = stepCount['steps'];
    } else {
      steps.value = 0;
    }
    // Sau khi cập nhật steps, gọi update để cập nhật giao diện
    update();
    // In ra log để kiểm tra
    await printStepCountLog();
  }
  void updateStepCount(int newSteps) async {
    var stepCount = await dbHelper.getStepCount(date);
    if (stepCount != null) {
      await dbHelper.updateStepCount(date, newSteps);
    } else {
      await dbHelper.saveStepCount(date, newSteps);
    }
    fetchStepCount();
    update();
  }

  Future<void> printStepCountLog() async {
    var stepCounts = await dbHelper.getAllStepCounts();
    print("Step Count Log:");
    stepCounts.forEach((stepCount) {
      print("Date: ${stepCount['date']}, Steps: ${stepCount['steps']}");
    });
  }

}
