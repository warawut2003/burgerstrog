import 'package:flutter/material.dart';
import '../model/food.dart'; // import โมเดลของรายการสินค้าที่ถูกใจ

class FavoritePage extends StatefulWidget {
  final List<Food> favoriteFoods; // รายการสินค้าที่ถูกใจ

  const FavoritePage({Key? key, required this.favoriteFoods}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'), // หัวข้อ AppBar
      ),
      body: ListView.builder(
        itemCount: widget.favoriteFoods.length,
        itemBuilder: (BuildContext context, int index) {
          // สร้างรายการสินค้าที่ถูกใจแต่ละรายการ
          return ListTile(
            title: Text(widget.favoriteFoods[index].name),
            subtitle: Text('Price: \$${widget.favoriteFoods[index].price}'),
            trailing: IconButton(
              icon: Icon(Icons.favorite), // ไอคอนหัวใจแสดงว่าเป็นสินค้าที่ถูกใจ
              onPressed: () {
                // ระบบการทำงานเมื่อคลิกที่ไอคอนหัวใจ
                // ในที่นี้คุณสามารถเพิ่มการลบสินค้าออกจากรายการสินค้าที่ถูกใจได้
                // โดยการเรียกใช้ setState เพื่อทำให้หน้าจอที่แสดงรายการสินค้าที่ถูกใจเปลี่ยนแปลง
                setState(() {
                  widget.favoriteFoods.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
