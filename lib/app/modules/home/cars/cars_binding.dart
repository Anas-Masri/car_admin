import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/modules/home/cars/cars_controller.dart';
import 'package:get/get.dart';

class CarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarController(homeRepo: Get.find<HomeRepo>()));
  }
}
