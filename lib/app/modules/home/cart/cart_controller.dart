import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartController({required this.homeRepo, required this.storageServices});

  @override
  void onInit() {
    getUserCars();
    super.onInit();
  }

  WidgetState widgetState = WidgetState.loading;

  final HomeRepo homeRepo;
  final StorageServices storageServices;

  List<Car> userCars = [];

  Future<void> getUserCars() async {
    widgetState = WidgetState.loading;
    update(["CartView"]);
    User user = storageServices.getUser()!;
    try {
      userCars = await homeRepo.getUserCars(userId: user.id);
      userCars.isEmpty
          ? widgetState = WidgetState.empty
          : widgetState = WidgetState.done;
    } on ErrorHandler catch (e) {
      widgetState = WidgetState.error;
      BotToast.showText(text: e.errorText);
    }
    update(["CartView"]);
  }

  Future<void> removeCarFromUserCars(Car removedCar) async {
    try {
      BotToast.showLoading();
      User user = storageServices.getUser()!;
      List<String> carIds = [];

      for (Car car in user.cars) {
        if (car.id != removedCar.id) {
          carIds.add(car.id);
        }
      }
      await homeRepo.patchUserCars(userId: user.id, carIds: carIds);
      user.cars.removeWhere((car) => car.id == removedCar.id);
      userCars.removeWhere((car) => car.id == removedCar.id);
      userCars.isEmpty
          ? widgetState = WidgetState.empty
          : widgetState = WidgetState.done;
      await storageServices.setUser(user);
      update(["CartView"]);
      BotToast.closeAllLoading();
    } on ErrorHandler catch (e) {
      BotToast.showText(text: e.errorText);
    }
  }
}
