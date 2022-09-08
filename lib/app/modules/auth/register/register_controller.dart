import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/auth_repo.dart';

class RegisterController extends GetxController {
  RegisterController({required this.authRepo, required this.storageServices});
  AuthRepo authRepo;
  StorageServices storageServices;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isloading = false;

  Future register() async {
    try {
      isloading = true;
      update();

      User user = await authRepo.register(
        fullName: fullNameController.text,
        username: usernameController.text,
        password: passwordController.text,
        city: cityController.text,
        phoneNumber: phoneNumberController.text,
      );
      await storageServices.setUser(user);

      isloading = false;
      update();

      Get.offAndToNamed("/mainHomePage");
    } catch (e) {
      isloading = false;
      update();
    }
  }

  void goToLogin() {
    Get.offAndToNamed("/loginPage");
  }
}
