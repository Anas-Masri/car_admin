import 'dart:developer';

import 'package:car_admin/app/core/models/car_model.dart';
import 'package:car_admin/app/core/models/filter_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  Dio dio;

  HomeRepo({required this.dio});
  Future<List<Car>> getCars(
      {required int skip, required String category}) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "skip": skip * 5,
        "take": 5,
      };
      if (category != "All") {
        queryParameters.addAll({"category": category});
      }
      Response response = await dio.get(
        "https://cars-mysql-backend.herokuapp.com/car/category",
        queryParameters: queryParameters,
      );

      log(queryParameters.toString());

      return Car.carList(response.data);
    } catch (e) {
      throw ErrorHandler("can't get cars");
    }
  }

  Future<void> patchUserCars(
      {required String userId, required List<String> carIds}) async {
    try {
      await dio.patch(
          "https://cars-mysql-backend.herokuapp.com/user/$userId/cars",
          data: {"cars": carIds});
    } catch (e) {
      throw ErrorHandler("can't add car");
    }
  }

  Future<List<Car>> getUserCars({required String userId}) async {
    try {
      Response response = await dio
          .get("https://cars-mysql-backend.herokuapp.com/user/$userId");

      return Car.carList(response.data["cars"]);
    } catch (e) {
      throw ErrorHandler("can't get User cars");
    }
  }

  Future<User> getUserDetails({required String userId}) async {
    try {
      Response response = await dio
          .get("https://cars-mysql-backend.herokuapp.com/user/$userId");

      return User.fromMap(response.data);
    } catch (e) {
      throw ErrorHandler("can't get User Details");
    }
  }

  Future<void> patchUserDetails({
    required String userId,
    String? fullname,
    String? username,
    String? password,
    String? city,
    String? phone,
  }) async {
    Map data = {
      "full_name": fullname,
      "username": username,
      "password": password,
      "city": city,
      "phone": phone,
    };
    data.removeWhere((key, value) => value == null || value == "");
    try {
      Response response = await dio.patch(
          "https://cars-mysql-backend.herokuapp.com/user/$userId",
          data: data);
    } catch (e) {
      log(e.toString());
      throw ErrorHandler("can't update User Details");
    }
  }

  Future<List<Car>> filterCar({
    required FilterModel filterModel,
    required int skip,
  }) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "take": 5,
        "brand": filterModel.brand,
        "model": filterModel.model,
        "yom": filterModel.yom,
        //"price": filterModel.startPrice,
        "skip": skip,
      };
      queryParameters.removeWhere((key, value) => value == null || value == "");
      Response response = await dio.get(
          "https://cars-mysql-backend.herokuapp.com/car/filter",
          queryParameters: queryParameters);
      return Car.carList(response.data);
    } catch (e) {
      log(e.toString());
      throw ErrorHandler("can't filter car");
    }
  }
}
