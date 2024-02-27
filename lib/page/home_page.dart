import 'package:flutter/material.dart';
import 'package:uispeed_grocery_shop/model/food.dart';
import 'package:uispeed_grocery_shop/page/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexCategory = 0;
  int indexBar = 0;
  String searchText = '';
  List<Food> favoriteFoods = [];

  // ฟังก์ชันค้นหาอาหาร
  void searchFood(String value) {
    setState(() {
      searchText = value.toLowerCase(); // แปลงคำค้นหาเป็นตัวพิมพ์เล็กทั้งหมด
    });
  }

  void _updateFavoriteFoods(List<Food> updatedFavoriteFoods) {
    setState(() {
      favoriteFoods = updatedFavoriteFoods; // อัปเดตรายการอาหารที่ชอบ
    });
  }

  @override
  Widget build(BuildContext context) {
    // สร้างรายการอาหารที่ผ่านการกรองโดยใช้คำค้นหา
    List<Food> filteredFoods = dummyFoods.where((food) {
      final name = food.name.toLowerCase();
      return name.contains(searchText); // กรองตามคำค้นหาในชื่ออาหาร
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green[200],
        currentIndex:
            indexBar, // เพิ่ม currentIndex เพื่อตรวจสอบว่าไอเท็มไหนถูกเลือก
        onTap: (int index) {
          // เพิ่ม onTap callback เพื่อรับค่า index ของไอคอนที่ถูกเลือก
          setState(() {
            indexBar = index; // กำหนดค่า indexCategory เป็น index ที่ถูกเลือก
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
      body: indexBar == 1
          ? CartScreen()
          : indexBar == 2
              ? NotificationScreen()
              : indexBar == 3
                  ? FavoriteScreen(
                      favoriteFoods: favoriteFoods,
                      updateFavoriteFoods: _updateFavoriteFoods,
                    )
                  : ListView(
                      children: [
                        const SizedBox(height: 16),
                        header(),
                        const SizedBox(height: 30),
                        title(),
                        const SizedBox(height: 20),
                        search(),
                        const SizedBox(height: 30),
                        categories(),
                        const SizedBox(height: 20),
                        gridFood(filteredFoods),
                      ],
                    ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Material(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.menu, color: Colors.black),
              ),
            ),
          ),
          const Spacer(),
          const Icon(Icons.location_on, color: Colors.green, size: 18),
          const Text('หรอย, Thailand'),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/salad.webp',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hi Thailand',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            'Find your food',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(8, 2, 6, 2),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: searchFood,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                hintText: 'Search food',
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: const Icon(Icons.bar_chart, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categories() {
    List list = ['Food', 'Fruits', 'Vegetables', 'Grocery', 'Drink'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              indexCategory = index;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(
                index == 0 ? 16 : 16,
                0,
                index == list.length - 1 ? 16 : 16,
                0,
              ),
              alignment: Alignment.center,
              child: Text(
                list[index],
                style: TextStyle(
                  fontSize: 22,
                  color: indexCategory == index ? Colors.green : Colors.grey,
                  fontWeight: indexCategory == index ? FontWeight.bold : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget gridFood(List<Food> foods) {
    return foods.isEmpty // ตรวจสอบว่ารายการอาหารที่ผ่านการกรองว่างเปล่าหรือไม่
        ? Center(
            child:
                Text('ไม่พบอาหาร')) // ถ้าว่างเปล่า ให้แสดงข้อความ "ไม่พบอาหาร"
        : GridView.builder(
            itemCount: foods.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 261,
            ),
            itemBuilder: (context, index) {
              Food food = foods[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(food: food);
                  }));
                },
                child: Container(
                  height: 261,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset(
                                food.image,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              food.name,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  food.cookingTime,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const Spacer(),
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  food.rate.toString(),
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '\$${food.price}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              food.isFavorite = !food
                                  .isFavorite; // สลับสถานะ isFavorite เมื่อคลิก
                            });
                          },
                          child: Icon(
                            food.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: food.isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
//Home
// class HomeContent extends StatelessWidget {
//   final List<Food> filteredFoods;
//   HomeContent(
//       {required this.filteredFoods}); // สร้าง constructor รับ filteredFoods
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         const SizedBox(height: 16),
//         header(),
//         const SizedBox(height: 30),
//         title(),
//         const SizedBox(height: 20),
//         search(),
//         const SizedBox(height: 30),
//         categories(),
//         const SizedBox(height: 20),
//         // อย่าลืมส่ง filteredFoods เข้าไปด้วย
//         gridFood(filteredFoods),
//       ],
//     );
//   }
// }

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child:
            Text('Your Cart is Empty'), // แสดงข้อความว่าตะกร้าสินค้าว่างเปล่า
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Text(
            'Your Notification is Empty'), // แสดงข้อความว่าตะกร้าสินค้าว่างเปล่า
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  final List<Food> favoriteFoods; // รายการอาหารที่ชอบ
  final Function(List<Food>) updateFavoriteFoods; // ฟังก์ชัน callback

  FavoriteScreen({
    Key? key,
    required this.favoriteFoods,
    required this.updateFavoriteFoods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // กรองรายการอาหารเพื่อแสดงเฉพาะรายการที่เป็น favorite
    List<Food> favoriteList =
        favoriteFoods.where((food) => food.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Foods'), // หัวข้อ AppBar
      ),
      body: favoriteList.isEmpty
          ? Center(
              child: Text(
                  'No favorite foods yet')) // ถ้ารายการอาหารที่ชอบว่างเปล่า ให้แสดงข้อความ "No favorite foods yet"
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (BuildContext context, int index) {
                // สร้างรายการอาหารที่ชอบแต่ละรายการ
                return ListTile(
                  title: Text(favoriteList[index].name),
                  subtitle:
                      Text('Price: \$${favoriteList[index].price.toString()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline), // ไอคอนลบรายการ
                    onPressed: () {
                      // การลบรายการอาหารที่ชอบเมื่อคลิกที่ไอคอน
                      // เรียกใช้ฟังก์ชัน callback เพื่ออัปเดตรายการอาหารใน HomePage
                      List<Food> updatedFavoriteList =
                          List<Food>.from(favoriteList);
                      updatedFavoriteList.removeAt(index);
                      updateFavoriteFoods(updatedFavoriteList);
                    },
                  ),
                );
              },
            ),
    );
  }
}
