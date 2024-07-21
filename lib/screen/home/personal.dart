import 'package:demo_1/database/background.dart';
import 'package:demo_1/screen/home/update.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/database/database_helper.dart';

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final _userNameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _goalController = TextEditingController();
  final _goallevelController = TextEditingController();
  String? _selectedActivity;
  final UsersDatabaseHelper dbHelper = UsersDatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadGoal();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    _goallevelController.dispose();
    super.dispose();
  }

  void _loadUserInfo() async {
    List<Map<String, dynamic>> users = await dbHelper.getUsers();
    if (users.isNotEmpty) {
      Map<String, dynamic> user = users.first;
      _userNameController.text = user['user_name'] ?? '';
      _ageController.text = user['age']?.toString() ?? '';
      _selectedGender = user['gender'] ?? '';
      _heightController.text = user['height']?.toString() ?? '';
      _weightController.text = user['weight']?.toString() ?? '';
      _selectedActivity = user['activity'] ?? '';
      setState(() {});
    }
  }

  void _loadGoal() async {
    List<Map<String, dynamic>> goals = await dbHelper.getGoal1();
    if (goals.isNotEmpty) {
      Map<String, dynamic> goal = goals.first;
      _goalController.text = goal['goal'] ?? '';
      _goallevelController.text = goal['goal_level'] ?? '';
      setState(() {});
    }
  }

  void updateUser() async {
    String userName = _userNameController.text;
    String gender = _selectedGender ?? '';
    int age = int.tryParse(_ageController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    String activity = _selectedActivity ?? '';

    List<Map<String, dynamic>> users = await dbHelper.getUsers();
    if (users.isNotEmpty) {
      int userId = users.first['id'];
      await dbHelper.updateUser(userName, gender, age, height, weight, activity);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cập nhật thành công')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân'),
        backgroundColor: Colors.orange,
      ),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text('Cập Nhật Thông Tin', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              buildInfoContainer(
                context,
                Icons.person,
                'Họ tên ',
                _userNameController,
              ),
              buildInfoContainer(
                context,
                Icons.cake,
                'Tuổi',
                _ageController,
              ),
              buildGenderContainer(context),
              buildInfoContainer(
                context,
                Icons.height,
                'Chiều cao',
                _heightController,
              ),
              buildInfoContainer(
                context,
                Icons.monitor_weight,
                'Cân nặng',
                _weightController,
              ),
              buildActivityContainer(context),
              buildInfoContainer(
                context,
                Icons.flag,
                'Mục tiêu',
                _goalController,
              ),
              buildInfoContainer1(
                context,
                Icons.assessment,
                'Cấp độ mục tiêu',
                _goallevelController,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  updateUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BMRPage1()),
                  );
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
                    'Cập Nhập',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 130,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoContainer(BuildContext context, IconData icon, String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        showEditDialog(label, controller);
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
            Text(controller.text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
    Widget buildInfoContainer1(BuildContext context, IconData icon, String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        showEditDialog(label, controller);
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
            Text(controller.text, style: TextStyle(fontSize: 0)),
          ],
        ),
      ),
    );
  }

  Widget buildGenderContainer(BuildContext context) {
    return Container(
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
              Icon(Icons.people, size: 30),
              SizedBox(width: 10),
              Text('Giới Tính', style: TextStyle(fontSize: 16)),
            ],
          ),
          DropdownButton<String>(
            value: _selectedGender,
            items: ['Male', 'Female']
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildActivityContainer(BuildContext context) {
    return Container(
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
              Icon(Icons.fitness_center, size: 30),
              SizedBox(width: 10),
              Text('Hoạt động', style: TextStyle(fontSize: 16)),
            ],
          ),
          DropdownButton<String>(
            value: _selectedActivity,
            items: [
              'Hoạt động rất ít',
              'Hoạt động nhẹ nhàng',
              'Hoạt động vừa phải',
              'Hoạt động nhiều',
              'Hoạt động cực nhiều'
            ].map((label) => DropdownMenuItem(
                  child: Text(label,style: TextStyle(fontSize: 14),),
                  value: label,
                )).toList(),
            onChanged: (value) {
              setState(() {
                _selectedActivity = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  void showEditDialog(String label, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa $label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Nhập $label mới'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
