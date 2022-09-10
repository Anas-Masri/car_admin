import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/add_car_card_widget.dart';
import 'package:car_admin/app/modules/home/car_store_list/car_store_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarStoreListView extends GetView<CarStoreListController> {
  const CarStoreListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed("/AddNewCarPage");
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Cars", style: TextStyle(color: Colors.black)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: (() => Get.back()),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: GetBuilder<CarStoreListController>(
          id: "CarStoreListView",
          builder: (_) {
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
                    child: Text("no cars yet in the store "),
                  ),
                );
              case WidgetState.error:
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: controller.getStoreCars,
                      child: const Text("try again"),
                    ),
                  ),
                );
              default:
                {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: NotificationListener(
                      onNotification: (t) {
                        if (t is ScrollEndNotification) {
                          if (controller.scrollController.position.pixels ==
                              controller
                                  .scrollController.position.maxScrollExtent) {
                            controller.pagination();
                          }
                          return true;
                        } else {
                          return false;
                        }
                      },
                      child: ListView.separated(
                        controller: controller.scrollController,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 20),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == controller.userCars.length) {
                            if (controller.widgetState ==
                                WidgetState.loadingMore) {
                              return const Center(
                                child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator()),
                              );
                            } else {
                              return const SizedBox();
                            }
                          } else {
                            return AddCarCardWidget(
                              car: controller.userCars[index],
                              onDelete: controller.removeCarFromUserCars,
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: controller.userCars.length + 1,
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}
