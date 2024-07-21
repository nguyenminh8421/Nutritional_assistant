import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/caculation/Caculation.dart';
import 'package:demo_1/database/database_helper.dart';

class BMRPage1 extends StatefulWidget {
  @override
  _BMRPageState createState() => _BMRPageState();
}

class _BMRPageState extends State<BMRPage1> {
  UsersDatabaseHelper _dbHelper = UsersDatabaseHelper();
  double? bmr;
  var goal_carb = 0.0;
  var goal_protein = 0.0;
  var goal_fat = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateBMR(); // Calculate BMR on initialization
  }

  Future<void> _calculateBMR() async {
    try {
      var user = await _dbHelper.getUser(1); // Assuming user_id = 1
      var goal = await _dbHelper.getGoal(1); // Assuming user_id = 1

      if (mounted && user != null && goal != null) {
        // Extract user and goal data
        double weight = user['weight'] as double;
        double height = user['height'] as double;
        int age = user['age'] as int;
        String gender = user['gender'] as String;
        String activity = user['activity'] as String;
        String goalValue = goal['goal'] as String;
        String goalLevel = goal['goal_level'] as String;

        // Create BMRCalculator instance
        BMRCalculator calculator = BMRCalculator(
          weight,
          height,
          age,
          gender,
          activity,
          goalValue,
          goalLevel,
        );

        // Calculate BMR and update state
        setState(() {
          bmr = calculator.calculateBMR();
          goal_carb = bmr! * 0.55;
          goal_protein = bmr! * 0.25;
          goal_fat = bmr! * 0.2;
        });

        // Update goals in database
        int updatedRows = await _dbHelper.updateGoal2(bmr!, goal_carb, goal_protein, goal_fat);
        print('Updated $updatedRows rows');

        // Delay for 3 seconds before popping back to the previous page
        Future.delayed(Duration(seconds: 0), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } else {
        print('User or Goal not found');
      }
    } catch (e) {
      print('Error calculating BMR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMR Calculation'),
      ),
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (bmr == null) // Show progress indicator while calculating
                CircularProgressIndicator(),
              if (bmr != null) // Show BMR result when available
                Text('BMR Result: $bmr'),
            ],
          ),
        ),
      ),
    );
  }
}
