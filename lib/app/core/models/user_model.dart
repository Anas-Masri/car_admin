import 'package:car_admin/app/core/models/car_model.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.password,
    required this.city,
    required this.phone,
    required this.cars,
  });
  
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String city;
  @HiveField(5)
  final String phone;
  @HiveField(6)
  final List<Car> cars;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        password: json["password"],
        city: json["city"],
        phone: json["phone"],
        cars: json["cars"] == null
            ? []
            : List<Car>.from(json["cars"].map((x) => Car.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "password": password,
        "city": city,
        "phone": phone,
        "cars": List<dynamic>.from(cars.map((x) => x.toMap())),
      };
}
