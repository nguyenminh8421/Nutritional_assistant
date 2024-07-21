import 'package:demo_1/database/database_helper.dart';
import 'package:demo_1/main.dart';
import 'package:get/get.dart';
import 'package:demo_1/database/food_database.dart';

class DatabaseController extends GetxController {
  final UsersDatabaseHelper _dbHelper = UsersDatabaseHelper();

  void deleteAllData() async {
    await _dbHelper.deleteAllData();
    // Điều hướng về MyApp sau khi xóa xong
    Get.offAll(() => MyApp());
    print("All tables deleted successfully.");
  }
}
