import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetailsView extends GetView<CarDetailsController> {
  const CarDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GetBuilder<CarDetailsController>(
                id: "CarDetailsController",
                builder: (_) {
                  switch (controller.widgetButtonState) {
                    case CarDetailsState.add:
                      return Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              controller.addCarToUserCars();
                            },
                            child: const Text("Add To Cart"),
                          ),
                        ),
                      );
                    case CarDetailsState.remove:
                      return Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[50]),
                            onPressed: () {
                              controller.removeCarFromUserCars();
                            },
                            child: const Text(
                              "Remove From Cart",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      );
                    case CarDetailsState.loading:
                      return Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: null,
                            child: const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator()),
                          ),
                        ),
                      );
                  }
                }),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.car.images.length,
                    itemBuilder: ((context, index) => Stack(
                          children: [
                            CachedNetworkImage(
                              width: double.infinity,
                              height: 250,
                              imageUrl: controller.car.images[index],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color.fromARGB(205, 8, 7, 44),
                                    Color.fromARGB(44, 16, 7, 7),
                                    Colors.transparent,
                                  ])),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "Detail Car",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Center(
              child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: controller.car.images.length,
                  effect: const WormEffect()),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.car.model,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        " ${controller.car.price} \$",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.car.brand,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700]),
                      ),
                      Text(
                        controller.car.category,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Year Of Manufacture : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800]),
                      ),
                      Text(
                        controller.car.yom,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Color :  ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600]),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Discretion : ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800]),
                  ),
                  Text(
                    controller.car.description,
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
