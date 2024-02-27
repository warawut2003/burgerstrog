import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        title: Text(
          'Payment Success',
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 60, // เพิ่มความสูงของ AppBar
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              top: 20, // เพิ่มระยะห่างด้านบน
            ),
            // เพิ่มไอคอน info ด้านขวา
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 40), // เพิ่มระยะห่างด้านบนของไอคอน
              Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20), // เพิ่มระยะห่างด้านบนของข้อความ
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popUntil(
                      context, ModalRoute.withName('/')); // ปิดหน้าต่างนี้
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // กำหนดสีเป็นสีเขียว
                ),
                child: Text(
                  'Close',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
