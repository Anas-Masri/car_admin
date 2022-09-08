import 'package:car_admin/app/core/repos/auth_repo.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/auth/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController(
        storageServices: Get.find<StorageServices>(),
        authRepo: Get.find<AuthRepo>()));
  }
}
