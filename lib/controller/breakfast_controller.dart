
import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BreakfastController extends GetxController {
  var mealId = 0.obs;
  final UsersDatabaseHelper db = UsersDatabaseHelper();

  Future<void> fetchTodayBreakfastId() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int? id = await getMealIdByDateAndType(today, 'sáng');
    if (id != null) {
      mealId.value = id;
    } else {
      print('Meal ID not found for today\'s breakfast');
    }
  }

  Future<int?> getMealIdByDateAndType(String date, String mealType) async {
    var client = await db;
    var result = await client!.rawQuery('''
      SELECT id FROM meals 
      WHERE date = ? AND meal_type = ?
    ''', [date, mealType]);

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    }
    return 7;
  }
}
