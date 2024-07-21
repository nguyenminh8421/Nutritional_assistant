import 'dart:ffi';
import 'package:demo_1/database/food_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UsersDatabaseHelper {
  static final UsersDatabaseHelper _instance = UsersDatabaseHelper.internal();

  factory UsersDatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  UsersDatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users_database35.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name TEXT,
        age INTEGER,
        gender TEXT,
        activity TEXT,
        bmi REAL,
        height REAL,
        weight REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        size REAL NOT NULL,
        measure TEXT NOT NULL,
        number INTEGER NOT NULL,
        name_word TEXT NOT NULL,
        calo REAL NOT NULL,
        carb REAL NOT NULL,
        fat REAL NOT NULL,
        protein REAL NOT NULL,
        type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        date TEXT DEFAULT CURRENT_TIMESTAMP,
        goal TEXT,
        goal_level TEXT,
        goal_calo REAL,
        goal_carb REAL,
        goal_protein REAL,
        goal_fat REAL,
        weight REAL,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date TEXT DEFAULT CURRENT_TIMESTAMP,
        meal_type TEXT,
        total_calo REAL,
        total_carb REAL,
        total_protein REAL,
        total_fat REAL,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE meal_food (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        meal_id INTEGER NOT NULL,
        food_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        FOREIGN KEY(meal_id) REFERENCES meals(id) ON DELETE CASCADE
      )
    ''');
 await db.execute('''
      CREATE TABLE step_count (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        steps INTEGER
      )
    ''');

    // Kiểm tra và import dữ liệu thức ăn
    bool isFoodsTableEmpty = await isTableEmpty(db, 'foods');
    if (isFoodsTableEmpty) {
      for (var food in initialFoodData) {
        await db.insert('foods', food);
      }
    }
  }

  Future<bool> isTableEmpty(Database db, String tableName) async {
    var result = await db.query(tableName);
    return result.isEmpty;
  }

  Future<int> saveUser(String userName, String gender, int age, String activity, double bmi, double height, double weight) async {
    var client = await db;
    return client!.insert('users', {
      'user_name': userName,
      'age': age,
      'gender': gender,
      'activity': activity,
      'bmi': bmi,
      'height': height,
      'weight': weight,
    });
  }
  Future<int> updateUser(String userName, String gender, int age, double height, double weight, String activity) async {
    var client = await db;
    
    // Lấy id của người dùng
    List<Map<String, dynamic>> results = await client!.query(
      'users',
      where: 'id = ?',
      whereArgs: [1],
    );

    if (results.isNotEmpty) {
      int id = results.first['id'];

      return client.update(
        'users',
        {
          'user_name': userName,
          'gender': gender,
          'age': age,
          'height': height,
          'weight': weight,
          'activity': activity,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } else {
      throw Exception("User not found");
    }
  }


  Future<int> saveGoal(int userId, String goal, String goalLevel, double goalCalo, double goalCarb, double goalProtein, double goalFat, double weight) async {
    var client = await db;
    return client!.insert('goals', {
      'user_id': userId,
      'goal': goal,
      'goal_level': goalLevel,
      'goal_calo': goalCalo,
      'goal_carb': goalCarb,
      'goal_protein': goalProtein,
      'goal_fat': goalFat,
      'weight': weight,
    });
  }

  Future<Map<String, dynamic>?> getGoal(int userId) async {
    var client = await db;
    List<Map<String, dynamic>> result = await client!.query(
      'goals',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int?> getUserId() async {
    var client = await db;
    List<Map<String, dynamic>> result = await client!.query(
      'users',
      columns: ['id'],
    );
    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    var client = await db;
    return client!.query('users');
  }
    Future<List<Map<String, dynamic>>> getGoal1() async {
    var client = await db;
    return client!.query('goals');
  }
    Future<Map<String, dynamic>?> getUser(int userId) async {
    var client = await db;
    List<Map<String, dynamic>> result = await client!.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getFoods() async {
    var client = await db;
    return client!.query('foods');
  }
Future<Map<String, dynamic>?> getGoals() async {
  var client = await db;
  List<Map<String, dynamic>> result = await client!.rawQuery(
    'SELECT * FROM goals ORDER BY id DESC LIMIT 1'
  );
  if (result.isNotEmpty) {
    return result.first;
  }
  return null;
}
    Future<String?> getUserName() async {
    var client = await db;
    List<Map<String, dynamic>> result = await client!.query('users', columns: ['user_name']);
    if (result.isNotEmpty) {
      return result.first['user_name'] as String?;
    }
    return null;
  }
Future<String?> getGoalCalo() async {
  var client = await db;
  List<Map<String, dynamic>> result = await client!.query('goals', columns: ['goal_calo']);
  if (result.isNotEmpty) {
    var goalCaloValue = result.first['goal_calo'];
    String? goalCalo;

    if (goalCaloValue is double) {
      goalCalo = goalCaloValue.toString();
    } else if (goalCaloValue is String) {
      goalCalo = goalCaloValue;
    }

    print('Goal Calo: $goalCalo'); // Log the value of goalCalo
    return goalCalo;
  }
  return null;
}


  Future<int> saveFood({
    required String name,
    required double size,
    required String measure,
    required int number,
    required String nameWord,
    required double calo,
    required double carb,
    required double fat,
    required double protein,
    required String type,
  }) async {
    var client = await db;
    return client!.insert('foods', {
      'name': name,
      'size': size,
      'measure': measure,
      'number': number,
      'name_word': nameWord,
      'calo': calo,
      'carb': carb,
      'fat': fat,
      'protein': protein,
      'type': type,
    });
  }

Future<void> deleteAllData() async {
  var client = await db;
  await client!.delete('users');
  await client.delete('goals');
  await client.delete('meals');
  await client.delete('meal_food');

  // Reset the ID counters
  await client.rawQuery("DELETE FROM sqlite_sequence WHERE name='users'");
  await client.rawQuery("DELETE FROM sqlite_sequence WHERE name='goals'");
  await client.rawQuery("DELETE FROM sqlite_sequence WHERE name='meals'");
  await client.rawQuery("DELETE FROM sqlite_sequence WHERE name='meal_food'");
}

 Future<bool> userExists() async {
    var client = await db;
    var result = await client!.query('users', limit: 1);
    print('userExists check result: $result'); // Thêm log
    return result.isNotEmpty;
  }
// Kiểm tra và tạo 5  bản ghi meals cho ngày hiện tại nếu chưa có
Future<void> checkAndCreateMealsForToday() async {
  var client = await db;
  String today = DateTime.now().toIso8601String().split('T')[0];

  List<Map<String, dynamic>> result = await client!.query(
    'meals',
    where: 'date = ?',
    whereArgs: [today],
  );

  List<int> mealIds = [];

  if (result.isEmpty) {
    List<String> mealTypes = ['sáng', 'trưa', 'chiều','phụ','uống'];

    for (String mealType in mealTypes) {
      int mealId = await client.insert('meals', {
        'user_id': 1,
        'date': today,
        'meal_type': mealType,
        'total_calo': 0.0,
        'total_carb': 0.0,
        'total_protein': 0.0,
        'total_fat': 0.0,
      });
      mealIds.add(mealId);
    }
    print('Created meals for today with IDs: $mealIds');
  } else {
    for (var meal in result) {
      mealIds.add(meal['id'] as int);
    }
    print('Meals for today already exist with IDs: $mealIds. Date: $today');
  }
}

  // Hàm thêm thông tin vào bảng meals với user_id mặc định là 1
  Future<int> insertMeal(String mealType, double totalCalo, double totalCarb, double totalProtein, double totalFat) async {
    var client = await db;
    int userId = 1; // Mặc định user_id là 1

    return client!.insert('meals', {
      'user_id': userId,
      'date': DateTime.now().toIso8601String(),
      'meal_type': mealType,
      'total_calo': totalCalo,
      'total_carb': totalCarb,
      'total_protein': totalProtein,
      'total_fat': totalFat,
    });
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
    return null;
  }
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    final dbClient = await db;
    return await dbClient!.rawQuery(sql, arguments);
  }
Future<int> insertMealFood(int mealId, int foodId, double amount) async {
  var client = await db;

  try {
    // Thực hiện việc thêm dữ liệu vào bảng meal_food
    int insertedId = await client!.insert('meal_food', {
      'meal_id': mealId,
      'food_id': foodId,
      'amount': amount,
    });

    if (insertedId != null) {
      print('Inserted meal_food with ID: $insertedId');
      return insertedId;
    } else {
      print('Failed to insert meal_food');
      return -1; // Or handle error as needed
    }
  } catch (e) {
    print('Error inserting meal_food: $e');
    return -1; // Or handle error as needed
  }
}

Future<Map<String, double>> calculateTotalNutrients(int mealId) async {
  var client = await db;
  List<Map<String, dynamic>> foods = await client!.rawQuery('''
    SELECT mf.amount, f.calo, f.carb, f.protein, f.fat
    FROM meal_food mf
    INNER JOIN foods f ON mf.food_id = f.id
    WHERE mf.meal_id = ?
  ''', [mealId]);

  double totalCalo = 0.0;
  double totalCarb = 0.0;
  double totalProtein = 0.0;
  double totalFat = 0.0;

  for (var food in foods) {
    double amount = food['amount'] as double;
    totalCalo += food['calo'] * amount;
    totalCarb += food['carb'] * amount;
    totalProtein += food['protein'] * amount;
    totalFat += food['fat'] * amount;
  }

  return {
    'total_calo': totalCalo,
    'total_carb': totalCarb,
    'total_protein': totalProtein,
    'total_fat': totalFat,
  };
}
Future<void> updateMealTotals(int mealId) async {
  Map<String, double> totals = await calculateTotalNutrients(mealId);

  var client = await db;
  await client!.update(
    'meals',
    {
      'total_calo': totals['total_calo'],
      'total_carb': totals['total_carb'],
      'total_protein': totals['total_protein'],
      'total_fat': totals['total_fat'],
    },
    where: 'id = ?',
    whereArgs: [mealId],
  );
}
 // Hàm lấy tổng các chất dinh dưỡng từ bảng meals
Future<double> getTotalCalo(String date) async {
  var client = await db;

  // Thực hiện truy vấn để lấy tổng total_calo cho một ngày cụ thể
  List<Map<String, dynamic>> results = await client!.rawQuery('''
    SELECT SUM(total_calo) AS totalCalo 
    FROM meals 
    WHERE date = ?
  ''', [date]);

  // Trả về kết quả
  if (results.isNotEmpty && results.first['totalCalo'] != null) {
    return results.first['totalCalo'] as double;
  } else {
    return 0.0;
  }
}
Future<double> getTotalCarb(String date) async {
  var client = await db;

  // Thực hiện truy vấn để lấy tổng total_calo
  List<Map<String, dynamic>> results = await client!.rawQuery('''
    SELECT SUM(total_carb) AS totalCarb 
    FROM meals 
    WHERE date = ?
  ''', [date]);

  // Trả về kết quả
  if (results.isNotEmpty && results.first['totalCarb'] != null) {
    return results.first['totalCarb'] as double;
  } else {
    return 0.0;
  }
}
Future<double> getTotalProtein(String date) async {
  var client = await db;

  // Thực hiện truy vấn để lấy tổng total_calo
  List<Map<String, dynamic>> results = await client!.rawQuery('''
    SELECT SUM(total_protein) AS totalProtein 
    FROM meals 
    WHERE date = ?
  ''', [date]);

  // Trả về kết quả
  if (results.isNotEmpty && results.first['totalProtein'] != null) {
    return results.first['totalProtein'] as double;
  } else {
    return 0.0;
  }
}
Future<double> getTotalFat(String date) async {
  var client = await db;

  // Thực hiện truy vấn để lấy tổng total_cal
    List<Map<String, dynamic>> results = await client!.rawQuery('''
    SELECT SUM(total_fat) AS totalFat 
    FROM meals 
    WHERE date = ?
  ''', [date]);

  // Trả về kết quả
  if (results.isNotEmpty && results.first['totalFat'] != null) {
    return results.first['totalFat'] as double;
  } else {
    return 0.0;
  }
}


Future<int> updateGoal1(String goal, String goalLevel) async {
  var client = await db;
  
  // Lấy id của mục tiêu (goal_id), giả sử là 1
  List<Map<String, dynamic>> results = await client!.query(
    'goals',
    where: 'id = ?',
    whereArgs: [1], // Assuming goal_id = 1
  );

  if (results.isNotEmpty) {
    int id = results.first['id'];

    return client.update(
      'goals',
      {
        'goal': goal,
        'goal_level': goalLevel,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  } else {
    throw Exception("Goal not found");
  }
}



  Future<int> updateGoal2(double goalCalo, double goalCarb, double goalProtein, double goalFat) async {
    if (db == null) {
      throw Exception("Database has not been initialized.");
    }

    var client = await db;

    // Kiểm tra xem cơ sở dữ liệu có bảng 'goals' và id = 1 không
    List<Map<String, dynamic>> results = await client!.query(
      'goals',
      where: 'id = ?',
      whereArgs: [1],
    );

    if (results.isNotEmpty) {
      print('Updating goals...');
      int updatedRows = await client.update(
        'goals',
        {
          'goal_calo': goalCalo,
          'goal_carb': goalCarb,
          'goal_protein': goalProtein,
          'goal_fat': goalFat,
        },
        where: 'id = ?',
        whereArgs: [1],
      );
      getGoalCalo();
      print('Updated $updatedRows rows  ');
      return updatedRows;
    } else {
      print("Goal not found for the user");
      return 0;
    }
  }
// Thêm hàm lọc vào đây
  Future<List<Map<String, dynamic>>> filterFoodsByTypeAndCalories(List<String> types, double maxCalories) async {
    var dbClient = await db;
    if (dbClient == null) {
      throw Exception("Database is not initialized");
    }
    // Tạo chuỗi điều kiện loại thức ăn
    String typeCondition = types.map((type) => "'$type'").join(", ");

    // Truy vấn cơ sở dữ liệu
    List<Map<String, dynamic>> results = await dbClient.rawQuery('''
      SELECT * FROM foods
      WHERE type IN ($typeCondition) AND calo < ?
    ''', [maxCalories]);

    return results;
  }

  Future<List<Map<String, dynamic>>> getMealsByDate(String date) async {
    var client = await db;
    return await client!.query(
      'meals',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<List<Map<String, dynamic>>> getMealFoods(int mealId) async {
    var client = await db;
    return await client!.rawQuery('''
      SELECT mf.amount, f.name, f.size, f.measure 
      FROM meal_food mf
      INNER JOIN foods f ON mf.food_id = f.id
      WHERE mf.meal_id = ?
    ''', [mealId]);
  }
  Future<List<Map<String, dynamic>>> getMealsWithFoodsByDate(String date) async {
    var client = await db;

    var result = await client!.rawQuery('''
      SELECT m.id as meal_id, m.meal_type, f.id as food_id, f.name, mf.amount, f.measure, f.calo
      FROM meals m
      JOIN meal_food mf ON m.id = mf.meal_id
      JOIN foods f ON mf.food_id = f.id
      WHERE m.date = ?
    ''', [date]);

    Map<int, Map<String, dynamic>> meals = {};
    for (var row in result) {
      int mealId = row['meal_id'] as int;
      if (!meals.containsKey(mealId)) {
        meals[mealId] = {
          'meal_id': mealId,
          'meal_type': row['meal_type'],
          'foods': <Map<String, dynamic>>[]
        };
      }
      (meals[mealId]!['foods'] as List<Map<String, dynamic>>).add({
        'food_id': row['food_id'],
        'name': row['name'],
        'amount': row['amount'],
        'measure': row['measure'],
        'calo': row['calo']
      });
    }

    return meals.values.toList();
  }

  Future<double> getTotalCaloriesByDate(String date) async {
    var client = await db;
    List<Map<String, dynamic>> result = await client!.rawQuery('''
      SELECT SUM(m.total_calo) AS totalCalories
      FROM meals m
      WHERE m.date = ?
    ''', [date]);

    if (result.isNotEmpty && result.first['totalCalories'] != null) {
      return result.first['totalCalories'] as double;
    } else {
      return 0.0;
    }
  }

   Future<int> saveStepCount(String date, int steps) async {
    var client = await db;
    return client!.insert('step_count', {
      'date': date,
      'steps': steps,
    });
  }

  Future<int> updateStepCount(String date, int steps) async {
    var client = await db;
    return client!.update(
      'step_count',
      {
        'steps': steps,
      },
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  Future<Map<String, dynamic>?> getStepCount(String date) async {
    var client = await db;
    List<Map<String, dynamic>> result = await client!.query(
      'step_count',
      where: 'date = ?',
      whereArgs: [date],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getStepCountsForLast7Days() async {
    var client = await db;
    String sevenDaysAgo = DateTime.now().subtract(Duration(days: 7)).toIso8601String().split('T')[0];

    List<Map<String, dynamic>> result = await client!.rawQuery('''
      SELECT * FROM step_count
      WHERE date >= ?
      ORDER BY date DESC
    ''', [sevenDaysAgo]);

    return result;
  }
    Future<List<Map<String, dynamic>>> getAllStepCounts() async {
    var client = await db;
    var result = await client!.query('step_count');
    return result;
  }
}


