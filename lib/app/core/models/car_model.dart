import 'package:hive/hive.dart';

part 'car_model.g.dart';

@HiveType(typeId: 2)
class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.color,
    required this.yom,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.images,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String brand;
  @HiveField(2)
  final String model;
  @HiveField(3)
  final String color;
  @HiveField(4)
  final String yom;
  @HiveField(5)
  final String price;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final String description;
  @HiveField(8)
  final String image;
  @HiveField(9)
  final List<String> images;

  static List<Car> carList(List data) =>
      data.map((car) => Car.fromMap(car)).toList();

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        color: json["color"],
        yom: json["yom"],
        price: json["price"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand": brand,
        "model": model,
        "color": color,
        "yom": yom,
        "price": price,
        "category": category,
        "description": description,
        "image": image,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
