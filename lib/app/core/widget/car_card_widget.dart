import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class CarCardWidget extends StatelessWidget {
  CarCardWidget({required this.car, required this.isfavorate, Key? key})
      : super(key: key);
  final Car car;
  bool isfavorate = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/CarDetailsViewPage", arguments: {"car": car});
      },
      child: Stack(alignment: Alignment.bottomCenter, children: [
        SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              width: 350,
              height: 250,
              imageUrl: car.image,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Container(
          width: 350,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(205, 8, 7, 44),
                    Color.fromARGB(33, 107, 103, 103),
                    Colors.transparent,
                  ])),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    car.id,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    car.price,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ],
              ),
              Text(
                car.model,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          width: 350,
          height: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 15),
                child: Icon(
                  FontAwesome.heart,
                  color: isfavorate ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
