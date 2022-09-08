import 'package:bot_toast/bot_toast.dart';
import 'package:car_admin/app/core/services/storage_services.dart';
import 'package:car_admin/app/modules/auth/login/login_binding.dart';
import 'package:car_admin/app/modules/auth/login/login_view.dart';
import 'package:car_admin/app/modules/auth/register/register_binding.dart';
import 'package:car_admin/app/modules/auth/register/register_view.dart';
import 'package:car_admin/app/modules/auth/wrapper/wrapper_binding.dart';
import 'package:car_admin/app/modules/auth/wrapper/wrapper_view.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_binding.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_view.dart';
import 'package:car_admin/app/modules/home/cars/cars_binding.dart';
import 'package:car_admin/app/modules/home/cars/cars_view.dart';
import 'package:car_admin/app/modules/home/cart/cart_binding.dart';
import 'package:car_admin/app/modules/home/cart/cart_view.dart';
import 'package:car_admin/app/modules/home/filter/filter_binding.dart';
import 'package:car_admin/app/modules/home/filter/filter_view.dart';
import 'package:car_admin/app/modules/home/main_home/main_home_binding.dart';
import 'package:car_admin/app/modules/home/main_home/main_home_view.dart';
import 'package:car_admin/app/modules/home/profile/profile_binding.dart';
import 'package:car_admin/app/modules/home/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await StorageServices.openStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: "/wrapperPage",
      getPages: [
        GetPage(
          name: "/loginPage",
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: "/registerPage",
          page: () => RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: "/wrapperPage",
          page: () => const Wrapperview(),
          binding: WrapperBinding(),
        ),
        GetPage(
          name: "/mainHomePage",
          page: () => const MainHomeView(),
          binding: MainHomeBinding(),
        ),
        GetPage(
          name: "/carPage",
          page: () => const CarView(),
          binding: CarBinding(),
        ),
        GetPage(
          name: "/cartPage",
          page: () => const CartView(),
          binding: CartBinding(),
        ),
        GetPage(
          name: "/profilePage",
          page: () => ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: "/CarDetailsViewPage",
          page: () => const CarDetailsView(),
          binding: CarDetailsBinding(),
        ),
        GetPage(
          name: "/filterPage",
          page: () => FilterView(),
          binding: FilterBinding(),
        ),
      ],
    );
  }
}
