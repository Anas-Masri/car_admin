import 'package:car_admin/app/core/repos/home_repo.dart';
import 'package:car_admin/app/modules/home/filter/filter_controller.dart';
import 'package:get/get.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FilterController(
      homeRepo: Get.find<HomeRepo>(),
    ));
  }
}
