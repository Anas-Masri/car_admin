import 'package:car_admin/app/core/repos/auth_repo.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/auth/wrapper/wrapper_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        Dio(BaseOptions(
          sendTimeout: 5000,
          connectTimeout: 5000,
          receiveTimeout: 5000,
        )),
        permanent: true);
    Get.put(AuthRepo(dio: Get.find<Dio>()), permanent: true);
    Get.put(StorageServices(), permanent: true);
    Get.put(WrapperController(storageServices: Get.find<StorageServices>()));
  }
}
