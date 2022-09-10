import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/home/car_store_list/car_store_list_controller.dart';
import 'package:get/get.dart';

class CarStoreListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarStoreListController(
        homeRepo: Get.find<HomeRepo>(),
        storageServices: Get.find<StorageServices>()));
  }
}
