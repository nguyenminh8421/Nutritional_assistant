import 'package:demo_1/database/background.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/screen/intro/intro3.dart';


class Intro2 extends StatelessWidget {
  const Intro2({super.key});

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
                    'assets/intro2.png',
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                 const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      "Bạn biết gì về chỉ số BMI?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
        
                  Container(
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                    alignment: Alignment.center,
                    child: const Text(
                      "CHỉ số BMI (Body Mass Index) hay còn gọi là chỉ số khối cơ thể, là một công cụ thường được sử dụng để đo lường lượng mỡ trong cơ thể. Nó giúp bạn xác định tình trạng hiện tại của cơ thể có đang bị béo phì hay không và ở mức độ nào. Nó được tính căn cứ trên số liệu về chiều cao và cân nặng  của cơ thể. Khi biết được chỉ số BMI, ta có thể lên kế hoạch giảm cân hoặc bổ sung dinh dưỡng phù hợp.  ",
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
                      MaterialPageRoute(builder: (context) => const Intro3()),
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
