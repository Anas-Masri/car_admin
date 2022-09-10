import 'dart:developer';

import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/custom_text_field.dart';
import 'package:car_admin/app/modules/home/add_new_car/add_new_car_controller.dart';
import 'package:flutter/material.dart';
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
                                        builder: (context) {
                                          return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.blue[900]),
                                              onPressed: controller
                                                          .widgetState ==
                                                      WidgetState.loading
                                                  ? null
                                                  : () {
                                                      if (formkey.currentState!
                                                          .validate()) {
                                                        controller
                                                            .patchUserDetails();
                                                      } else {
                                                        log("error from validate");
                                                      }
                                                    },
                                              child: controller.widgetState ==
                                                      WidgetState.loading
                                                  ? const CircularProgressIndicator()
                                                  : const Text("Choose Color"));
                                        });
                                  }),
                            ),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton(
                                onPressed: controller.logout,
                                child: const Text("Log Out"),
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
}
 /* void pickColor(BuildContext context) {
    showDialog (
        context: context,
        builder: (context){
         AlertDialog(
            title: const Text("select color car"),
            content: SingleChildScrollView(child: ColorPicker(
        pickerColor: controller.pickercolor,
        onColorChanged: controller.changeColor,
              ),

          )
          );
  });
  

*/
