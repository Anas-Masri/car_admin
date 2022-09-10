import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/home/add_new_car/add_new_car_controller.dart';
import 'package:get/get.dart';

class AddNewCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddNewCarController(
      homeRepo: Get.find<HomeRepo>(),
      storageServices: Get.find<StorageServices>(),
    ));
  }
}
