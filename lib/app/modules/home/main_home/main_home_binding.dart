import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/modules/home/cars/cars_binding.dart';
import 'package:car_admin/app/modules/home/main_home/main_home_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainHomeController());
    Get.put(HomeRepo(dio: Get.find<Dio>()));

    CarBinding().dependencies();
    //ProfileBinding().dependencies();
    //CartBinding().dependencies();
  }
}
