import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCarCardWidget extends StatelessWidget {
  AddCarCardWidget({
    required this.onDelete,
    required this.car,
    Key? key,
  }) : super(key: key);
  final void Function(Car car) onDelete;
  Car car;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Get.toNamed("/CarDetailsViewPage", arguments: {"car": car});
            },
            child: SizedBox(
              child: CachedNetworkImage(
                width: 100,
                height: 100,
                imageUrl: car.image,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      car.model,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      car.brand,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Text(
                  car.description,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${car.price} \$",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    Text(
                      car.yom,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, bottom: 60),
            child: InkWell(
              onTap: () {
                onDelete(car);
              },
              child: const Icon(
                Icons.close_sharp,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
