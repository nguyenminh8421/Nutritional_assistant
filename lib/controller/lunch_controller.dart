import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LunchController extends GetxController {
  var lunchId = 0.obs;
  final UsersDatabaseHelper db = UsersDatabaseHelper();

  Future<void> fetchTodayLunchId() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int? id = await getMealIdByDateAndType(today, 'trưa');
    if (id != null) {
      lunchId.value = id;
    } else {
      print('Không tìm thấy Meal ID cho bữa trưa hôm nay');
    }
  }

  Future<int?> getMealIdByDateAndType(String date, String mealType) async {
    var client = await db.db; // Đảm bảo truy cập đúng instance database
    var result = await client!.rawQuery('''
      SELECT id FROM meals 
      WHERE date = ? AND meal_type = ?
    ''', [date, mealType]);

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    }
    return null; // Trả về null nếu không tìm thấy Meal ID
  }
}