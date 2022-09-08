import 'package:car_admin/app/core/widget/custom_text_field.dart';
import 'package:car_admin/app/core/widget/wellcom_widget.dart';
import 'package:car_admin/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const WellcomWidget(),
            const Padding(
              padding: EdgeInsets.only(left: 40, bottom: 25),
              child: Text(
                "Signup",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
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
                      hintText: "Enter Your Password",
                      lable: "Password",
                      obscureText: true,
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password shouldn't be empty";
                        } else if (value.length < 8) {
                          return "Password shouldn't be shorter than 8 character";
                        } else {
                          return null;
                        }
                      }),
                  CustomTextField(
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
                    width: 200,
                    child:
                        GetBuilder<RegisterController>(builder: (controller) {
                      return ElevatedButton(
                          onPressed: controller.isloading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    controller.register();
                                  }
                                },
                          child: controller.isloading
                              ? const CircularProgressIndicator()
                              : const Text("register"));
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: controller.goToLogin,
                          child: const Text("login"))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
