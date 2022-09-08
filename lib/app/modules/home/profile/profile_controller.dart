import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ProfileController({
    required this.homeRepo,
    required this.storageServices,
  });
  HomeRepo homeRepo;
  late User user;
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
      update(["ProfileView"]);
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
    update(["ProfileView"]);
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
}
