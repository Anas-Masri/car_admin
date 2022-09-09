import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/car_card_widget.dart';
import 'package:car_admin/app/modules/home/filter/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterView extends GetView<FilterController> {
  FilterView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Filter", style: TextStyle(color: Colors.black)),
          actions: const [Icon(Icons.arrow_back_ios)],
        ),
        body: GetBuilder<FilterController>(
            id: "filterView",
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
                      child: Text("no cars filterd"),
                    ),
                  );
                case WidgetState.error:
                  return SizedBox(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: controller.filterSearch,
                        child: const Text("try again"),
                      ),
                    ),
                  );
                default:
                  return NotificationListener(
                    onNotification: (t) {
                      if (t is ScrollEndNotification) {
                        if (controller.scrollController.position.pixels ==
                            controller
                                .scrollController.position.maxScrollExtent) {
                          controller.paginationFilter();
                        }

                        return true;
                      } else {
                        return false;
                      }
                    },
                    child: ListView.separated(
                      controller: controller.scrollController,
                      itemCount: controller.cars.length + 1,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == controller.cars.length) {
                          if (controller.widgetState ==
                              WidgetState.loadingMore) {
                            return const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return CarCardWidget(
                            isfavorate: false,
                            car: controller.cars[index],
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  );
              }
            }));
  }
}
