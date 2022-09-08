import 'package:car_admin/app/core/models/car_model.dart';
import "package:car_admin/app/core/models/user_model.dart";
import "package:hive_flutter/hive_flutter.dart";

class StorageServices {
  Box<User> userbox = Hive.box<User>("userBox");

  static Future<void> openStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CarAdapter());
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>("userBox");
  }

  Future<void> setUser(User user) async {
    await userbox.put("appUser", user);
  }

  User? getUser() {
    User? user = userbox.get("appUser");
    return user;
  }

  Future<void> deleteUser() async {
    await userbox.delete("appUser");
  }
}
