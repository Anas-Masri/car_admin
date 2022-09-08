import 'package:flutter/material.dart';

class WellcomWidget extends StatelessWidget {
  const WellcomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: double.infinity,
        child: Image.asset(
          "assets/images/top_shape.png",
          fit: BoxFit.fill,
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 50, top: 50),
        child: Text(
          "Welcome",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      )
    ]);
  }
}
