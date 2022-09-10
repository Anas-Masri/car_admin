import 'dart:developer';

import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/custom_text_field.dart';
import 'package:car_admin/app/modules/home/add_new_car/add_new_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class AddNewCarView extends GetView<AddNewCarController> {
  AddNewCarView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Car",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: GetBuilder<AddNewCarController>(
            id: "AddNewCarView",
            builder: (_) {
              switch (controller.widgetState) {
                case WidgetState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case WidgetState.error:
                  return Center(
                    child: ElevatedButton(
                        onPressed: controller.getUserDetails,
                        child: const Text("try agin")),
                  );

                default:
                  return Form(
                    key: formkey,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        CustomTextField(
                            hintText: "enter car name",
                            lable: "Car Name",
                            controller: TextEditingController(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Car Name shouldn't be empty";
                              } else if (value.length > 10) {
                                return "Car Name shouldn't be more than 10 character";
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            hintText: "model",
                            lable: "Model",
                            controller: TextEditingController(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Model shouldn't be empty";
                              } else if (value.length > 10) {
                                return "Model shouldn't be more than 10 character";
                              } else {
                                return null;
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: CustomTextField(
                                  hintText: "Brand",
                                  lable: "Brand",
                                  obscureText: true,
                                  controller: TextEditingController(),
                                  validator: (value) {
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: CustomTextField(
                                  hintText: "",
                                  lable: "Year Of manufacture",
                                  obscureText: true,
                                  controller: TextEditingController(),
                                  validator: (value) {
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: CustomTextField(
                                  hintText: "price",
                                  lable: "Price",
                                  obscureText: true,
                                  controller: TextEditingController(),
                                  validator: (value) {
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: CustomTextField(
                                  hintText: "",
                                  lable: "Category",
                                  obscureText: true,
                                  controller: TextEditingController(),
                                  validator: (value) {
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        CustomTextField(
                            maxLines: 5,
                            hintText: "Description",
                            lable: "Description",
                            controller: TextEditingController(),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Description shouldn't be empty";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              height: 40,
                              width: MediaQuery.of(context).size.width / 3,
                              child: GetBuilder<AddNewCarController>(
                                  id: "updateUser",
                                  builder: (_) {
                                    return GetBuilder<AddNewCarController>(
                                        id: "changeColor",
                                        builder: (_) {
                                          return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blue[900]),
                                              onPressed: () {
                                                pickColor(context);
                                              },
                                              child: controller.widgetState ==
                                                      WidgetState.loading
                                                  ? const CircularProgressIndicator()
                                                  : const Text("Choose Color"));
                                        });
                                  }),
                            ),
                            SizedBox(
                              //decoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(border: BoxBorder())  ),
                              height: 40,
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                        width: 2, color: Colors.blue[800]!)),
                                onPressed: () async {
                                  controller.pickImages();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.image_search_sharp,
                                        color: Colors.blue[800]),
                                    Text(
                                      "Add image",
                                      style: TextStyle(color: Colors.blue[800]),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
              }
            }));
  }

  pickColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("select color car"),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: controller.pickercolor,
                onColorChanged: controller.changeColor,
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    controller.changeColor(controller.pickercolor);
                    Navigator.of(context).pop();
                    log(controller.pickercolor.toString());
                  },
                  child: const Text("select"))
            ],
          );
        });
  }
}
