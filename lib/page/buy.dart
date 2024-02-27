import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/food.dart';
import 'successful.dart';
import 'receipt.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({Key? key, required this.food, required this.quantity})
      : super(key: key);
  final Food food;
  final int quantity;

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  TextEditingController _controller4 = new TextEditingController();

  double sale = 0;
  double buy = 0;
  double qty = 0;
  double change = 0;
  void calculation(double paidAmount, double totalAmount) {
    try {
      sale = totalAmount;
      buy = paidAmount;
      if (paidAmount >= totalAmount) {
        setState(() {
          change = paidAmount - totalAmount;
        });
      } else {
        // แสดงข้อความแจ้งเตือนถ้าจำนวนที่ชำระน้อยกว่าราคารวม
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ข้อผิดพลาด"),
              content: Text("จำนวนที่ชำระน้อยกว่าราคารวม"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ตกลง"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาดในการแปลงข้อมูล
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ข้อผิดพลาด"),
            content: Text("โปรดป้อนจำนวนที่ถูกต้อง"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("ตกลง"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // ปุ่มย้อนกลับ
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
                context); // ใช้ Navigator.pop เพื่อย้อนกลับไปยังหน้าก่อนหน้านี้
          },
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(child: body()),
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                    bottomLeft: Radius.circular(80))),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ชำระเงิน",
                    style: GoogleFonts.robotoMono(
                        fontSize: 35, color: Colors.white),
                  ),
                  Text(
                    "ยอดชำระ",
                    style: GoogleFonts.robotoMono(
                        fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 40, 0),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    widget.food.image, // แสดงรูปภาพอาหาร
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  widget.food.name, // แสดงชื่ออาหาร
                  style: GoogleFonts.robotoMono(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                inputForm("ราคา", _controller1, "เช่น 600000",
                    widget.food.price.toString(),
                    readOnly: true),
                inputForm("จำนวน", _controller2, "เช่น 100000",
                    widget.quantity.toString(),
                    readOnly: true),
                inputForm("ราคารวม", _controller3, "เช่น 100000",
                    (widget.food.price * widget.quantity).toString(),
                    readOnly: true),
                inputForm("จำนวนที่ชำระ", _controller4, "เช่น 400 ", ""),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              calculation(
                  double.parse(_controller4.text), // จำนวนที่ชำระ
                  double.parse(_controller3.text));

              if (double.parse(_controller4.text) >=
                  double.parse(_controller3.text)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ReceiptPage(
                      totalAmount: double.parse(_controller3.text),
                      paidAmount: double.parse(_controller4.text),
                      change: change,
                      foodItems: [widget.food],
                    );
                  },
                );
              }
            },
            child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    "Buy",
                    style: GoogleFonts.robotoMono(
                        fontSize: 15, color: Colors.white),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget inputForm(String title, TextEditingController controller,
      String hinttext, String initialValue,
      {bool readOnly = false}) {
    controller.text = initialValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(fontSize: 15),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hinttext),
          ),
        )
      ],
    );
  }
}
