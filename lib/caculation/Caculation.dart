class BMRCalculator {
  // Properties
  double weight; // in kilograms
  double height; // in centimeters
  int age; // in years
  String gender; // 'male' or 'female'
  String activity; // activity level as text
  String goal; // goal: 'Tăng Cân', 'Giữ Cân', 'Giảm Cân'
  String goalLevel; // goal level: 'nhanh', 'vừa', 'chậm'

  // Constructor
  BMRCalculator(this.weight, this.height, this.age, this.gender, this.activity, this.goal, this.goalLevel);

  // Method to calculate BMR
  double calculateBMR() {
    double bmr;
    if (gender.toLowerCase() == 'male') {
      // BMR formula for males
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else if (gender.toLowerCase() == 'female') {
      // BMR formula for females
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    } else {
      throw Exception("Invalid gender. Please provide 'male' or 'female'.");
    }

    // Calculate calories needed based on activity level
    double activityMultiplier;
    if (activity.toLowerCase() == 'hoạt động rất ít') {
      activityMultiplier = 1.2;
    } else if (activity.toLowerCase() == 'hoạt động nhẹ nhàng') {
      activityMultiplier = 1.375;
    } else if (activity.toLowerCase() == 'hoạt động vừa phải') {
      activityMultiplier = 1.55;
    } else if (activity.toLowerCase() == 'hoạt động nhiều') {
      activityMultiplier = 1.725;
    } else if (activity.toLowerCase() == 'hoạt động cực nhiều') {
      activityMultiplier = 1.9;
    } else {
      throw Exception("Invalid activity level. Please provide one of: 'Hoạt động rất ít', 'Hoạt động nhẹ nhàng', 'Hoạt động vừa phải', 'Hoạt động nhiều', 'Hoạt động cực nhiều'.");
    }

    // Adjust calories needed based on goal and goal level
    double caloriesNeeded = bmr * activityMultiplier;
    if (goal.toLowerCase() == 'tăng cân') {
      if (goalLevel.toLowerCase() == 'mức tăng/giảm cân nhanh = 1.5kg/tuần') {
        caloriesNeeded += 1375;
      } else if (goalLevel.toLowerCase() == 'mức tăng/giảm cân vừa = 1kg/tuần') {
        caloriesNeeded += 825;
      } else if (goalLevel.toLowerCase() == 'mức tăng/giảm cân chậm = 0.5kg/tuần') {
        caloriesNeeded += 275;
      }
    } else if (goal.toLowerCase() == 'giảm cân') {
      if (goalLevel.toLowerCase() == 'mức tăng/giảm cân nhanh = 1.5kg/tuần') {
        caloriesNeeded -= 1375;
      } else if (goalLevel.toLowerCase() == 'mức tăng/giảm cân vừa = 1kg/tuần') {
        caloriesNeeded -= 825;
      } else if (goalLevel.toLowerCase() == 'mức tăng/giảm cân chậm = 0.5kg/tuần') {
        caloriesNeeded -= 275;
      }
    }

    return caloriesNeeded;
  }
}
