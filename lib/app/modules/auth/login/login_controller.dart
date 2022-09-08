import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/auth_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController({required this.authRepo, required this.storageServices});
  AuthRepo authRepo;
  StorageServices storageServices;
  bool isloading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errormessage = "";
  Future login() async {
    try {
      isloading = true;
      errormessage = "";
      update(["errormessage", "ElevatedButton"]);
      User user = await authRepo.login(
          username: usernameController.text, password: passwordController.text);
      await storageServices.setUser(user);
      Get.offAndToNamed("/mainHomePage");

      isloading = false;
      update(["ElevatedButton"]);
    } on ErrorHandler catch (e) {
      isloading = false;
      errormessage = e.errorText;
      update(["errormessage", "ElevatedButton"]);
    }
  }

  void goToRegister() {
    Get.offAndToNamed("/registerPage");
  }
}
