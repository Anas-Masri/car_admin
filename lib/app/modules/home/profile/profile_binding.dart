import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/home/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(
      homeRepo: Get.find<HomeRepo>(),
      storageServices: Get.find<StorageServices>(),
    ));
  }
}
