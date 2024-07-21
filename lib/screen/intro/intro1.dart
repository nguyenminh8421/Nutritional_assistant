import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/screen/intro/intro2.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  //const intro1({super.key});


  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height*0.05;
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Stack (
            children: [
              Column(
               //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(height: height1,),
                  Image.asset(
                    'assets/intro1.png',
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      "Biến các số đo sức khỏe thành hành động thực tế",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                    alignment: Alignment.center,
                    child: const Text(
                      "Hãy tưởng tượng bạn bước lên một chiếc cân, không chỉ để nhìn thấy những con số mà còn để hiểu rõ ý nghĩa của nó đối với sức khỏe của bạn. Ứng dụng 'Trợ Lý Sức Khỏe' của chúng tôi đồng hành cùng bạn trong hành trình hướng tới một cuộc sống khỏe mạnh và tràn đầy sức khỏe hơn. Bạn đã bao giờ thắc mắc cân nặng ảnh hưởng như thế nào đến sức khỏe và cuộc sống của bạn? Ứng dụng của chúng tôi không chỉ để đo lường, nó còn cung cấp cho bạn những lộ trình tăng giảm cân một cách khoa học và hợp lý. Bạn đã sẵn sàng biến những con số thành những bước đi đầu tiên hướng tới tới mục tiêu sức khỏe của mình chưa?",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
        
                  ),
          
        
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
                      MaterialPageRoute(builder: (context) => const Intro2()),
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
          ),
         
        ),
      ),
    );
  }
}
