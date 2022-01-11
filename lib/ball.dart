import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  double ballX;
  double ballY;
  Color colorBall;

  MyBall(
      {required this.colorBall,
      required this.ballX,
      required this.ballY,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorBall,
        ),
      ),
    );
  }
}
