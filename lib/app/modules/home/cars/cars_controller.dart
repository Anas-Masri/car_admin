import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/constant/const_list.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:car_admin/app/core/models/filter_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarController extends GetxController {
  CarController({required this.homeRepo});
  ScrollController scrollController = ScrollController();
  TextEditingController brandcontroller = TextEditingController();
  TextEditingController modelecontroller = TextEditingController();
  int categoryIndex = 0;
  RangeValues priceRangValues = const RangeValues(
    100000,
    1000000,
  );
  List<String> categuerySelectedList = [];
  WidgetState widgetState = WidgetState.loading;
  final HomeRepo homeRepo;
  int skip = 0;
  bool isSelected = false;
  List<Car> carList = [];
  List<Car> userCarList = [];
  Future<void> getCars([bool isPagination = false]) async {
    try {
      if (!isPagination) {
        skip = 0;
        carList = [];
        widgetState = WidgetState.loading;
      } else {
        widgetState = WidgetState.loadingMore;
      }
      update(["ListViewVertical"]);

      List<Car> tempCarList = await homeRepo.getCars(
          skip: skip, category: categoryList[categoryIndex]);

      carList.addAll(tempCarList);
      if (!isPagination) {
        carList.isEmpty
            ? widgetState = WidgetState.empty
            : widgetState = WidgetState.done;
      } else {
        tempCarList.isEmpty
            ? widgetState = WidgetState.noMoreData
            : widgetState = WidgetState.done;
      }
      if (widgetState == WidgetState.noMoreData) {
        BotToast.showText(text: "no more cars");
      }
    } on ErrorHandler catch (e) {
      if (!isPagination) {
        widgetState = WidgetState.error;
        BotToast.showText(text: e.errorText);
      }
    }
    update(["ListViewVertical"]);
  }

  @override
  void onInit() {
    getCars();
    getUserCars();
    super.onInit();
  }

  void pagination() {
    if (widgetState != WidgetState.loadingMore &&
        widgetState != WidgetState.noMoreData) {
      skip++;
      getCars(true);
    }
  }

  void changCateguryIndex(int categoryIndex) {
    if (this.categoryIndex != categoryIndex) {
      this.categoryIndex = categoryIndex;
      getCars(false);
      update(["categoryIndex"]);
    }
  }

  DateTime? picked;
  Future<void> selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    log(picked.toString());
    update(["YOM"]);
  }

  void changPriceRange(RangeValues values) {
    priceRangValues = values;
    update(["priceRangValues"]);
  }

  void changeCateguryIndex(int index) {
    bool isSelected = cheakSelectedCategury(index);
    if (isSelected) {
      categuerySelectedList.remove(categoryList[index]);
    } else {
      categuerySelectedList.add(categoryList[index]);
    }
    update(["changeCateguryIndex"]);
  }

  bool cheakSelectedCategury(int index) {
    return categuerySelectedList.contains(categoryList[index]);
  }

  void filterSearch() {
    Get.back();
    Get.toNamed("/filterPage", arguments: {
      "filter": FilterModel(
        categories: categuerySelectedList,
        brand: brandcontroller.text,
        model: modelecontroller.text,
        yom: picked == null ? null : picked!.year.toStringAsExponential(),
        endPrice: priceRangValues.end.toString(),
        startPrice: priceRangValues.start.toString(),
      )
    });

    resetFilter();
  }

  void resetFilter() {
    categuerySelectedList = [];
    brandcontroller = TextEditingController();
    modelecontroller = TextEditingController();
    picked = null;
    priceRangValues = const RangeValues(100000, 1000000);
  }

  Future<void> getUserCars() async {
    User user = StorageServices().getUser()!;
    try {
      userCarList = await homeRepo.getUserCars(userId: user.id);
    } on ErrorHandler catch (e) {
      BotToast.showText(text: e.errorText);
    }
  }

  bool isfavorate(int index) {
    User user = StorageServices().getUser()!;
    for (Car car in user.cars) {
      if (car.id == carList[index].id) {
        return true;
      }
    }
    update();
    return false;
  }
}
