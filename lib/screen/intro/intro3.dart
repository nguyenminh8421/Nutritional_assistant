import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/screen/import_information/entername.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});


  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height*0.05;
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: height1,),
                  Image.asset(
                    'assets/intro3.png',
                    width: MediaQuery.of(context).size.width*0.95,
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      'Ứng dụng Trợ Lý Dinh Dưỡng Cá Nhân giúp bạn ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10,),
                
                  BulletList(),
        
                ],
              ),
               Positioned(
                top: MediaQuery.of(context).size.height * 0.9, // 80% của chiều cao màn hình
                left: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenderImagePage()),
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
                      'Bắt Đầu',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
    
  }
}
class BulletList extends StatelessWidget {
  final List<String> items = [
    'Tính toán BMI: Ứng dụng giúp người sử dụng tính toán nhanh chóng chỉ số BMI của cơ thể, đồng thời đánh giá tình trạng sức khỏe.',
    'Lập lộ trình tăng/giảm cân: Dựa vào chỉ số BMI và yêu cầu của người dùng, ứng dụng đưa ra lộ trình ăn uống với lượng calo phù hợp với thể trạng từng người.',
    'Gợi ý món ăn: Các món ăn phù hợp được gợi ý vào từng bữa ăn đảm bảo đủ lượng calo nạp vào cơ thể, danh sách các món ăn được liệt kê đầy đủ và chi tiết.',
    'Người bạn đồng hành: Nhắc nhở người sử dụng vào mỗi bữa ăn về lượng calo cần nạp, cuối ngày sẽ tổng kết và đánh giá quá trình thực hiện lộ trình ăn uống của người sử dụng.'
  ];

   BulletList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => BulletPoint(text: item)).toList(),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // Tách từ đầu tiên và phần còn lại của câu
    final parts = text.split(': ');
    final firstWord = '${parts[0]}:';
    final restOfText = parts.length > 1 ? parts.sublist(1).join(': ') : '';

    return Padding(
      padding: const EdgeInsets.only( left: 15.0,right: 5),
      child: RichText(
        text: TextSpan(
          children: [
            const WidgetSpan(
              child: Text('_ ', style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            TextSpan(
              text: firstWord,
              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black),
            ),
            TextSpan(
              text: ' $restOfText',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}