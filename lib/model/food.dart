class Food {
  Food({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.rate,
    required this.kcal,
    required this.cookingTime,
    required this.description,
    required this.isFavorite,
  });

  String id;
  String image;
  String name;
  int price;
  double rate;
  String kcal;
  String cookingTime;
  String description;
  bool isFavorite = false;

  void toggleFavorite() {
    // เมทอดที่ใช้สำหรับสลับสถานะของ isFavorite
    isFavorite = !isFavorite;
  }

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        rate: json["rate"].toDouble(),
        kcal: json["kcal"],
        cookingTime: json["cooking_time"],
        description: json["description"],
        isFavorite: json["_isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "rate": rate,
        "kcl": kcal,
        "cooking_time": cookingTime,
        "description": description,
        "_isFavorite": isFavorite,
      };
}

final dummyFoods = [
  Food(
      id: '1',
      image: 'asset/burger.jpeg',
      name: 'Burger Cheese',
      price: 60,
      rate: 4.5,
      kcal: '100',
      cookingTime: '20 Min',
      description:
          'เป็นแฮมเบอร์เกอร์ซึ่งมีเนยแข็งวางอยู่บนเนื้อ ส่วนใหญ่จะนำเนยแข็งวางลงบนแผ่นเนื้อในระหว่างที่กำลังร้อนอยู่บนเตาย่าง เพื่อที่จะให้เนยแข็งละลายลงบนแผ่นเนื้อ ภายในตัวชีสเบอร์เกอร์มักมีส่วนผสมอื่น ๆ',
      isFavorite: false),
  Food(
      id: '2',
      image: 'asset/pizza.jpeg',
      name: 'Pizza Italian ',
      price: 70,
      rate: 4.5,
      kcal: '100',
      cookingTime: '30 Min',
      description:
          'เป็นอาหารอิตาลีและอาหารจานด่วนประเภทหนึ่ง ซึ่งชาวอิตาลีเป็นผู้คิดค้น มีลักษณะเป็นแป้งแผ่นกลมแบนราดด้วยซอสมะเขือเทศ แล้วทำให้สุกโดยการอบในเตาอบ',
      isFavorite: false),
  Food(
      id: '3',
      image: 'asset/salad.webp',
      name: 'Salad Health',
      price: 50,
      rate: 4,
      kcal: '20',
      cookingTime: '15 Min',
      description:
          'อาหารผักสดหลายชนิดผสมผเสกัน, ผักสดที่ใช้กินสด ๆ , สลัด, ยำผักสด, ยุคที่เจริญรุ่งเรืองที่สุดของนักประพันธ์ salad dressing. n. ซอสสำหรับราดสลัด ประกอบด้วยน้ำมันพืช น้ำส้มหรือไข่แดง, น้ำปรุงสลัด',
      isFavorite: false),
  Food(
      id: '4',
      image: 'asset/salmon.jpeg',
      name: 'Salmon Fresh Mounth',
      price: 80,
      rate: 4.8,
      kcal: '60',
      cookingTime: '18 Min',
      description:
          'แซลมอนย่างกับสลัดคีนัว เป็นเมนูแซลมอนหมักเครื่องเทศกลิ่นหอมย่างสุกกำลังดี ผิวนอกกรอบ เนื้อในนุ่ม เสิร์ฟกับ “คีนัว” ซูเปอร์ฟู้ดฮ็อตฮิตในกลุ่มคนรักสุขภาพ',
      isFavorite: false),
];
