import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailsController extends GetxController {
  CarDetailsController({
    required this.homeRepo,
    required this.storageServices,
  });
  HomeRepo homeRepo;
  StorageServices storageServices;
  late Car car;
  PageController pageController = PageController();
  CarDetailsState widgetButtonState = CarDetailsState.add;
  @override
  void onInit() {
    car = Get.arguments["car"];
    checkCarExist();
    super.onInit();
  }

  Future<void> addCarToUserCars() async {
    try {
      log("start");
      widgetButtonState = CarDetailsState.loading;
      update(["CarDetailsController"]);
      User user = storageServices.getUser()!;
      List<String> carIds = [car.id];

      for (Car car in user.cars) {
        carIds.add(car.id);
      }
      await homeRepo.patchUserCars(userId: user.id, carIds: carIds);
      user.cars.add(car);
      await storageServices.setUser(user);
      widgetButtonState = CarDetailsState.remove;

      log("done");
    } on ErrorHandler catch (e) {
      widgetButtonState = CarDetailsState.add;
      BotToast.showText(text: e.errorText);
    }
    update(["CarDetailsController"]);
  }

  Future<void> removeCarFromUserCars() async {
    try {
      widgetButtonState = CarDetailsState.loading;
      update(["CarDetailsController"]);

      User user = storageServices.getUser()!;
      List<String> carIds = [];

      for (Car car in user.cars) {
        if (car.id != this.car.id) {
          carIds.add(car.id);
        }
      }
      await homeRepo.patchUserCars(userId: user.id, carIds: carIds);
      user.cars.removeWhere((car) => car.id == this.car.id);
      await storageServices.setUser(user);
      widgetButtonState = CarDetailsState.add;

      log("done");
    } on ErrorHandler catch (e) {
      widgetButtonState = CarDetailsState.remove;

      BotToast.showText(text: e.errorText);
    }
    update(["CarDetailsController"]);
  }

  void checkCarExist() {
    User user = storageServices.getUser()!;
    for (Car car in user.cars) {
      if (car.id == this.car.id) {
        widgetButtonState = CarDetailsState.remove;
      }
    }
  }
}

enum CarDetailsState {
  add,
  remove,
  loading,
}
