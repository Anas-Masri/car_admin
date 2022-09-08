import 'package:car_admin/app/core/constant/const_list.dart';
import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/car_card_widget.dart';
import 'package:car_admin/app/core/widget/custom_text_field.dart';
import 'package:car_admin/app/modules/home/cars/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class CarView extends GetView<CarController> {
  const CarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.toNamed("/profilePage");
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(Icons.person, color: Colors.blue),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                filter(context);
              },
              child: const Icon(FontAwesome.sliders, color: Colors.blue),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "Car Shop",
          style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        ),
      ),
      body: Column(
        children: [
          _listViewHorizontal(),
          _listViewVertical(context),
        ],
      ),
    );
  }

  Widget _listViewVertical(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 226,
        child: GetBuilder<CarController>(
            id: "ListViewVertical",
            builder: (_) {
              switch (controller.widgetState) {
                case WidgetState.loading:
                  return const Center(child: CircularProgressIndicator());

                case WidgetState.error:
                  return Center(
                    child: ElevatedButton(
                      onPressed: controller.getCars,
                      child: const Text("try Again "),
                    ),
                  );
                case WidgetState.empty:
                  return const Center(child: Text("there is no cars "));
                default:
                  return NotificationListener(
                    child: ListView.separated(
                      controller: controller.scrollController,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      itemCount: controller.carList.length + 1,
                      itemBuilder: (context, i) {
                        if (i == controller.carList.length) {
                          if (controller.widgetState ==
                              WidgetState.loadingMore) {
                            return const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return CarCardWidget(car: controller.carList[i]);
                        }
                      },
                      separatorBuilder: (context, i) {
                        return const Center(
                          child: SizedBox(
                            height: 20,
                          ),
                        );
                      },
                    ),
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
                  );
              }
            }));
  }

  Widget _listViewHorizontal() {
    return GetBuilder<CarController>(
        id: "categoryIndex",
        builder: (_) {
          return SizedBox(
              height: 90,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: categoryList.length,
                  itemBuilder: (context, i) {
                    return Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: controller.categoryIndex == i
                                    ? Colors.blue
                                    : Colors.grey),
                            onPressed: () {
                              controller.changCateguryIndex(i);
                            },
                            child: Text(categoryList[i])));
                  },
                  separatorBuilder: (context, i) {
                    return const Center(child: SizedBox(width: 20));
                  }));
        });
  }

  void filter(BuildContext context) {
    Get.bottomSheet(
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.70,
          child: ListView(
              padding: const EdgeInsets.only(
                  top: 25, left: 20, right: 20, bottom: 25),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CustomTextField(
                          lable: "Brand",
                          hintText: "Brand",
                          controller: controller.brandcontroller,
                        )),
                    InkWell(
                      onTap: () {
                        controller.selectDate(context);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: GetBuilder<CarController>(
                            id: "YOM",
                            builder: (_) {
                              return CustomTextField(
                                isenable: false,
                                lable: "Year Of manufacture",
                                hintText: "",
                                controller: TextEditingController(
                                    text: controller.picked == null
                                        ? null
                                        : controller.picked!.year.toString()),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  lable: "Year Of manufacture",
                  hintText: "Brand",
                  controller: TextEditingController(),
                ),
                const Text(
                  "price",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GetBuilder<CarController>(
                    id: "priceRangValues",
                    builder: (_) {
                      return RangeSlider(
                        activeColor: Colors.blueAccent,
                        inactiveColor: Colors.black,
                        labels: RangeLabels(
                            controller.priceRangValues.start.toString(),
                            controller.priceRangValues.end.toString()),
                        divisions: 10,
                        max: 1000000,
                        min: 100000,
                        values: controller.priceRangValues,
                        onChanged: controller.changPriceRange,
                      );
                    }),
                GetBuilder<CarController>(
                    id: "changeCateguryIndex",
                    builder: (_) {
                      return SizedBox(
                        height: 126,
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: categoryList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 4,
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: controller
                                              .cheakSelectedCategury(index)
                                          ? Colors.blue
                                          : Colors.grey),
                                  onPressed: () {
                                    controller.changeCateguryIndex(index);
                                  },
                                  child: Text(
                                    categoryList[index],
                                  ));
                            }),
                      );
                    }),
                ElevatedButton(
                  onPressed: controller.filterSearch,
                  child: const Text("Search"),
                )
              ]),
        ),
        isScrollControlled: true);
  }
}
