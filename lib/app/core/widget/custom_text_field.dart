import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isBoarderd = false,
    this.isenable = true,
    Key? key,
    this.validator,
    required this.controller,
    required this.lable,
    required this.hintText,
  }) : super(key: key);
  final TextInputType keyboardType;
  final isBoarderd;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String lable;
  final bool isenable;

  OutlineInputBorder outlineInputBorder() {
    if (isBoarderd) {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(25),
      );
    } else {
      return OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(25),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: isenable,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              focusedErrorBorder: outlineInputBorder(),
              errorBorder: outlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 13),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: outlineInputBorder(),
              enabledBorder: outlineInputBorder()),
          controller: controller,
          validator: validator,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
