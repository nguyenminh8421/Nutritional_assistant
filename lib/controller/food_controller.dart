import 'package:demo_1/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:demo_1/database/food_database.dart';

class FoodController extends GetxController {
  var foods = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var selectedType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadFoods();
  }

  Future<void> loadFoods() async {
    final dbHelper = UsersDatabaseHelper();
    final foodList = await dbHelper.getFoods();
    foods.value = foodList;
    isLoading.value = false;
  }

  void filterFoods() {
    final dbHelper = UsersDatabaseHelper();
    dbHelper.getFoods().then((foodList) {
      var filteredFoods = foodList;
      if (searchQuery.isNotEmpty) {
        filteredFoods = filteredFoods
            .where((food) =>
                food['name'].toString().toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList();
      }
      if (selectedType.isNotEmpty) {
        filteredFoods = filteredFoods
            .where((food) => food['type'] == selectedType.value)
            .toList();
      }
      foods.value = filteredFoods;
    });
  }

  void toggleSelectedType(String type) {
    if (selectedType.value == type) {
      selectedType.value = '';
    } else {
      selectedType.value = type;
    }
    filterFoods();
  }
}
