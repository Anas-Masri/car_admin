import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:car_admin/app/core/models/filter_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  FilterController({
    required this.homeRepo,
  });
  ScrollController scrollController = ScrollController();
  WidgetState widgetState = WidgetState.loading;
  HomeRepo homeRepo;
  late FilterModel filterModel;
  int skip = 0;
  List<Car> cars = [];
  @override
  void onInit() {
    filterModel = Get.arguments["filter"];

    filterSearch();
    super.onInit();
  }

  Future<void> filterSearch([bool ispagination = false]) async {
    try {
      if (!ispagination) {
        widgetState = WidgetState.loading;
        skip = 0;
        cars = [];
      } else {
        widgetState = WidgetState.loadingMore;
      }
      update(["filterView"]);

      List<Car> tempList = await homeRepo.filterCar(
        filterModel: filterModel,
        skip: skip,
      );
      cars.addAll(tempList);

      if (!ispagination) {
        cars.isEmpty
            ? widgetState = WidgetState.empty
            : widgetState = WidgetState.done;
      } else {
        tempList.isEmpty
            ? widgetState = WidgetState.noMoreData
            : widgetState = WidgetState.done;
      }
      if (widgetState == WidgetState.noMoreData) {
        BotToast.showText(text: "no more cars");
      }
    } on ErrorHandler catch (e) {
      widgetState = WidgetState.error;

      BotToast.showText(text: e.errorText);
    }
    log(widgetState.toString());
    update(["filterView"]);
  }

  void paginationFilter() {
    if (widgetState != WidgetState.loadingMore &&
        widgetState != WidgetState.noMoreData) {
      skip += 5;
      filterSearch(true);
    }
  }
}
