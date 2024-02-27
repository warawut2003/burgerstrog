import 'package:flutter/material.dart';
import 'package:uispeed_grocery_shop/model/food.dart';
import 'successful.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceiptPage extends StatelessWidget {
  final double totalAmount;
  final double paidAmount;
  final double change;
  final List<Food> foodItems;

  const ReceiptPage({
    Key? key,
    required this.totalAmount,
    required this.paidAmount,
    required this.change,
    required this.foodItems,
  }) : super(key: key);

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
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green,
        title: Text(
          'Receipt',
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food Items:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      foodItems[index].image, // แสดงรูปภาพอาหาร
                      height: 100, // กำหนดความสูงของรูปภาพ
                      width: 100, // กำหนดความกว้างของรูปภาพ
                    ),
                    title: Text(
                      '${foodItems[index].name} (${foodItems[index].price.toStringAsFixed(2)})', // แสดงชื่ออาหารและราคาอาหาร
                      style: TextStyle(fontSize: 18.0),
                    ),

                    // Add additional information or customization as needed
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Total Amount: $totalAmount',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Paid Amount: $paidAmount',
              style: TextStyle(fontSize: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Change: $change',
                  style: TextStyle(fontSize: 20.0),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    // Navigate to the successful page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PaymentSuccessPage();
                    }));
                  },
                  label: Text(
                    'Confirm',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
