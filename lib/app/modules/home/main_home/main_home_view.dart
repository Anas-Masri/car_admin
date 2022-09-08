import 'package:car_admin/app/modules/home/cars/cars_view.dart';
import 'package:car_admin/app/modules/home/cart/cart_view.dart';
import 'package:car_admin/app/modules/home/main_home/main_home_controller.dart';
import 'package:car_admin/app/modules/home/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeView extends GetView<MainHomeController> {
  const MainHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainHomeController>(
        id: "PageView",
        builder: (_) {
          return Scaffold(
            body: PageView(
                controller: controller.pageController,
                onPageChanged: controller.changePageScrollIndex,
                children: [
                  const CarView(),
                  const CartView(),
                  ProfileView(),
                ]),
            bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
                ],
                currentIndex: controller.currentIndex,
                onTap: controller.changePageIndex),
          );
        });
  }
}
