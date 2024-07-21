import 'package:flutter/material.dart';

class Goal extends StatefulWidget {
  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  String selectedGoal = 'Tăng cân'; // Giá trị mặc định
  String selectedActivityLevel = 'Nhanh'; // Giá trị mặc định

  void updateGoal(String newGoal) {
    setState(() {
      selectedGoal = newGoal;
    });
  }

  void updateActivityLevel(String newLevel) {
    setState(() {
      selectedActivityLevel = newLevel;
    });
  }

  void saveGoals() {
    // Đây là nơi bạn sẽ lưu giá trị vào cơ sở dữ liệu
    // Ví dụ: gọi phương thức updateGoal của UsersDatabaseHelper
    // UsersDatabaseHelper.updateGoal(selectedGoal, selectedActivityLevel);
    
    // Hiển thị thông báo hoặc cập nhật UI khi lưu thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cập nhật mục tiêu thành công')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mục Tiêu'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Cập Nhật Mục Tiêu',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildDropdownContainer(
              context,
              Icons.flag,
              'Mục tiêu',
              selectedGoal,
              [
                'Tăng cân',
                'Giữ cân',
                'Giảm cân',
              ],
              updateGoal,
            ),
            buildDropdownContainer(
              context,
              Icons.local_activity,
              'Mức độ',
              selectedActivityLevel,
              [
                'Nhanh',
                'Vừa',
                'Chậm',
              ],
              updateActivityLevel,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveGoals();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  'Tiếp Tục',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownContainer(BuildContext context, IconData icon, String label,
      String selectedValue, List<String> items, Function(String) onChanged) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Chỉnh sửa $label'),
              content: DropdownButtonFormField<String>(
                value: selectedValue,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  onChanged(newValue!);
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Hủy'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 30),
                SizedBox(width: 10),
                Text(label, style: TextStyle(fontSize: 16)),
              ],
            ),
            Text(selectedValue, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
