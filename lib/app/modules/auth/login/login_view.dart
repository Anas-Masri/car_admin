import 'package:car_admin/app/core/widget/custom_text_field.dart';
import 'package:car_admin/app/core/widget/wellcom_widget.dart';
import 'package:car_admin/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const WellcomWidget(),
            const Padding(
              padding: EdgeInsets.only(left: 40, bottom: 25),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  CustomTextField(
                      lable: "Username",
                      hintText: "Enter Your Username",
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
                  const SizedBox(height: 15),
                  CustomTextField(
                      lable: "Password",
                      obscureText: true,
                      hintText: "Enter Your Password",
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
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: GetBuilder<LoginController>(
                              id: "ElevatedButton",
                              builder: (controller) {
                                return ElevatedButton(
                                    onPressed: controller.isloading
                                        ? null
                                        : () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              controller.login();
                                            }
                                          },
                                    child: controller.isloading
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            "Login",
                                            style: TextStyle(fontSize: 20),
                                          ));
                              }),
                        ),
                        GetBuilder<LoginController>(
                            id: "errormessage",
                            builder: (controler) {
                              return Text(
                                controller.errormessage,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Forget Password?",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: controller.goToRegister,
                          child: const Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
