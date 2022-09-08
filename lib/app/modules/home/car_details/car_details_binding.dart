import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_controller.dart';
import 'package:get/get.dart';

class CarDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarDetailsController(
      homeRepo: Get.find<HomeRepo>(),
      storageServices: Get.find<StorageServices>(),
    ));
  }
}
