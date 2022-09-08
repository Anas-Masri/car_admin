import 'package:get/get.dart';

import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/services/storage_services.dart';

class WrapperController extends GetxController {
  WrapperController({
    required this.storageServices,
  });
  StorageServices storageServices;
  Future<void> cheakUserExist() async {
    await Future.delayed(const Duration(seconds: 1));
    User? user = storageServices.getUser();
    if (user == null) {
      Get.offAndToNamed("/loginPage");
    } else {
      Get.offAndToNamed("/mainHomePage");
    }
  }

  @override
  void onInit() {
    cheakUserExist();
    super.onInit();
  }
}
