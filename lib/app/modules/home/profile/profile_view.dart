import 'dart:developer';

import 'package:car_admin/app/core/enums/widget_state_enum.dart';
import 'package:car_admin/app/core/widget/custom_text_field.dart';
import 'package:car_admin/app/modules/home/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: GetBuilder<ProfileController>(
            id: "ProfileView",
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
                            isBoarderd: true,
                            hintText: "Enter Your FullName",
                            lable: "FullName",
                            controller: controller.fullNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "FullName shouldn't be empty";
                              } else if (value.length > 20) {
                                return "FullName shouldn't be more than 20 character";
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            isBoarderd: true,
                            hintText: "Enter Your Username",
                            lable: "Username",
                            controller: controller.usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username shouldn't be empty";
                              } else if (value.length > 10) {
                                return "Username shouldn't be more than 10 character";
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            isBoarderd: true,
                            hintText: "Enter Your Password",
                            lable: "Password",
                            obscureText: true,
                            controller: controller.passwordController,
                            validator: (value) {
                              return null;
                            }),
                        CustomTextField(
                            isBoarderd: true,
                            hintText: "Enter Your PhoneNumber  ",
                            lable: "Phonenumber",
                            controller: controller.phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Phone shouldn't be empty";
                              } else if (value.length != 10) {
                                return "Phone shoul be 10 character";
                              } else {
                                return null;
                              }
                            }),
                        CustomTextField(
                            isBoarderd: true,
                            hintText: "Enter Your City",
                            lable: "City",
                            controller: controller.cityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "City shouldn't be empty";
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: GetBuilder<ProfileController>(
                              id: "updateUser",
                              builder: (_) {
                                return ElevatedButton(
                                    onPressed: controller.widgetState ==
                                            WidgetState.loading
                                        ? null
                                        : () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              controller.patchUserDetails();
                                            } else {
                                              log("error from validate");
                                            }
                                          },
                                    child: controller.widgetState ==
                                            WidgetState.loading
                                        ? const CircularProgressIndicator()
                                        : const Text("Update"));
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: controller.logout,
                            child: const Text("Log Out"),
                          ),
                        )
                      ],
                    ),
                  );
              }
            }));
  }
}
