import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewCarController extends GetxController {
  AddNewCarController({
    required this.homeRepo,
    required this.storageServices,
  });
  final ImagePicker picker = ImagePicker();
  HomeRepo homeRepo;
  late User user;
  File? image;
  Color pickercolor = Colors.white;
  StorageServices storageServices;
  late TextEditingController fullNameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController cityController;
  late TextEditingController phoneNumberController;
  WidgetState widgetState = WidgetState.loading;
  Future<void> getUserDetails() async {
    try {
      widgetState = WidgetState.loading;
      update(["AddNewCarView"]);
      user = storageServices.getUser()!;
      user = await homeRepo.getUserDetails(userId: user.id);
      fullNameController = TextEditingController(text: user.fullName);
      usernameController = TextEditingController(text: user.username);
      cityController = TextEditingController(text: user.city);
      phoneNumberController = TextEditingController(text: user.phone);
      widgetState = WidgetState.done;
    } on ErrorHandler catch (e) {
      widgetState = WidgetState.empty;
      BotToast.showText(text: e.errorText);
    }
    update(["AddNewCarView"]);
  }

  Future<void> patchUserDetails() async {
    try {
      widgetState = WidgetState.loading;
      update(["updateUser"]);
      await homeRepo.patchUserDetails(
        userId: user.id,
        fullname: fullNameController.text,
        username: usernameController.text,
        password: passwordController.text,
        city: cityController.text,
        phone: phoneNumberController.text,
      );
      await storageServices.setUser(user);
      BotToast.showText(text: "User Updated Successfully");
    } on ErrorHandler catch (e) {
      BotToast.showText(text: e.errorText);
    }
    widgetState = WidgetState.done;

    update(["updateUser"]);
  }

  Future<void> logout() async {
    await storageServices.deleteUser();
    Get.offAndToNamed("/wrapperPage");
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  void changeColor(Color color) {
    pickercolor = color;
    update(["changeColor"]);
  }

  Future<void> pickImages() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      this.image = imageTemp;
      log(imageTemp.toString());
    } on ErrorHandler catch (e) {
      BotToast.showText(text: e.errorText);
    }
  }
}
