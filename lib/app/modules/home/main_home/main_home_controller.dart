import 'package:car_admin/app/modules/home/cart/cart_binding.dart';
import 'package:car_admin/app/modules/home/profile/profile_binding.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  int currentIndex = 0;

  PageController pageController = PageController();

  void changePageIndex(int currentIndex) {
    this.currentIndex = currentIndex;
    // pageController.animateToPage(currentIndex,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    pageController.jumpToPage(currentIndex);
    update(["PageView"]);

    if (currentIndex == 0) {
    } else if (currentIndex == 1) {
      CartBinding().dependencies();
    } else if (currentIndex == 2) {
      ProfileBinding().dependencies();
    }
  }

  void changePageScrollIndex(int currentIndex) {
    this.currentIndex = currentIndex;
    update(["PageView"]);
    if (currentIndex == 0) {
    } else if (currentIndex == 1) {
      CartBinding().dependencies();
    } else if (currentIndex == 2) {
      ProfileBinding().dependencies();
    }
  }
}
