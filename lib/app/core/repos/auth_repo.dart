import 'dart:developer';

import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:dio/dio.dart';

String baseUrl = "https://cars-mysql-backend.herokuapp.com";

class AuthRepo {
  AuthRepo({required this.dio});
  Dio dio;
  Future<User> login(
      {required String username, required String password}) async {
    try {
      log("login");

      Response response = await dio.post("$baseUrl/user/login",
          data: {"username": username, "password": password});
      log(response.data.toString());

      return User.fromMap(response.data);
    } on DioError catch (e) {
      int statusCode = e.response != null ? e.response!.statusCode! : 0;
      if (statusCode == 409) {
        throw ErrorHandler("Wrong Password");
      } else if (statusCode == 404) {
        throw ErrorHandler("User Not Found");
      } else {
        throw ErrorHandler("UnKnown Error");
      }
    } catch (_) {
      throw ErrorHandler("UnKnown Error");
    }
  }

  Future<User> register({
    required String username,
    required String password,
    required String fullName,
    required String city,
    required String phoneNumber,
  }) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post("$baseUrl/user/register", data: {
        "full_name": fullName,
        "username": username,
        "password": password,
        "city": city,
        "phone": phoneNumber
      });
      log(response.data.toString());
      return User.fromMap(response.data);
    } catch (e) {
      throw ErrorHandler("UnKnown Error");
    }
  }
}
