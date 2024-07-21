import 'package:demo_1/database/background.dart';
import 'package:demo_1/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFoodPage extends StatelessWidget {
  final UsersDatabaseHelper dbHelper = UsersDatabaseHelper();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController caloController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Thêm món ăn'),
      ),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text('Nhập thông tin món ăn',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),textAlign: TextAlign.center,),
              _buildTextField(nameController, 'Tên món ăn'),
              _buildTextField(sizeController, 'Kích thước(gram)', isNumber: true),
              _buildTextField(caloController, 'Calo', isNumber: true),
              _buildTextField(carbController, 'Carbohydrate', isNumber: true),
              _buildTextField(fatController, 'Chất béo', isNumber: true),
              _buildTextField(proteinController, 'Chất đạm', isNumber: true),
              _buildTextField(typeController, 'Loại thực phẩm'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await dbHelper.saveFood(
                    name: nameController.text,
                    size: double.parse(sizeController.text),
                    measure: 'gram', // Đơn vị đo mặc định
                    number: 1, // Số lượng mặc định
                    nameWord: 'phần', // Từ mô tả mặc định
                    calo: double.parse(caloController.text),
                    carb: double.parse(carbController.text),
                    fat: double.parse(fatController.text),
                    protein: double.parse(proteinController.text),
                    type: typeController.text,
                  );
                  Get.snackbar('Success', 'Món ăn đã được thêm thành công',
                    snackPosition: SnackPosition.BOTTOM);
                  clearTextFields();
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
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: isNumber ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      ),
    );
  }

  void clearTextFields() {
    nameController.clear();
    sizeController.clear();
    caloController.clear();
    carbController.clear();
    fatController.clear();
    proteinController.clear();
    typeController.clear();
  }
}
