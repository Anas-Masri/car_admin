import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CarStoreListController extends GetxController {
  CarStoreListController(
      {required this.homeRepo, required this.storageServices});
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    getStoreCars();
    super.onInit();
  }

  WidgetState widgetState = WidgetState.loading;
  int skip = 0;
  final HomeRepo homeRepo;
  final StorageServices storageServices;
  List<Car> userCars = [];

  Future<void> getStoreCars([bool isPagination = false]) async {
    try {
      if (!isPagination) {
        widgetState = WidgetState.loading;
        skip = 0;
        userCars = [];
      } else {
        widgetState = WidgetState.loadingMore;
      }
      update(["CarStoreListView"]);

      List<Car> tempList = await homeRepo.getStoreCars(skip: skip);
      userCars.addAll(tempList);
      if (!isPagination) {
        userCars.isEmpty
            ? widgetState = WidgetState.empty
            : widgetState = WidgetState.done;
      } else {
        tempList.isEmpty
            ? widgetState = WidgetState.noMoreData
            : widgetState = WidgetState.done;
      }
    } on ErrorHandler catch (e) {
      widgetState = WidgetState.error;
      BotToast.showText(text: e.errorText);
    }
    update(["CarStoreListView"]);
  }

  void pagination() {
    if (widgetState != WidgetState.loadingMore &&
        widgetState != WidgetState.noMoreData) {
      skip += 10;
      getStoreCars(true);
    }
  }

  Future<void> removeCarFromUserCars(Car removedCar) async {
    try {
      BotToast.showLoading();
      User user = storageServices.getUser()!;
      List<String> carIds = [];

      for (Car car in user.cars) {
        if (car.id != removedCar.id) {
          carIds.add(car.id);
        }
      }
      await homeRepo.patchUserCars(userId: user.id, carIds: carIds);
      user.cars.removeWhere((car) => car.id == removedCar.id);
      userCars.removeWhere((car) => car.id == removedCar.id);
      userCars.isEmpty
          ? widgetState = WidgetState.empty
          : widgetState = WidgetState.done;
      await storageServices.setUser(user);
      update(["AddNewCarView"]);
      BotToast.closeAllLoading();
    } on ErrorHandler catch (e) {
      BotToast.showText(text: e.errorText);
    }
  }
}
