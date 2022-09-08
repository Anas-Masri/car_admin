import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/car_cart_widget.dart';
import 'package:car_admin/app/modules/home/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("My Cars", style: TextStyle(color: Colors.black)),
        actions: const [Icon(Icons.arrow_back_ios)],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getUserCars();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: GetBuilder<CartController>(
              id: "CartView",
              builder: (controller) {
                switch (controller.widgetState) {
                  case WidgetState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case WidgetState.empty:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: const Center(
                        child: Text("no cars yet"),
                      ),
                    );
                  case WidgetState.error:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: controller.getUserCars,
                          child: const Text("try again"),
                        ),
                      ),
                    );
                  default:
                    {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return CarCartWidget(
                            car: controller.userCars[index],
                            onDelete: controller.removeCarFromUserCars,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: controller.userCars.length,
                      );
                    }
                }
              }),
        ),
      ),
    );
  }
}
