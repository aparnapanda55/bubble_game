import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  const MyPlayer({
    Key? key,
    required this.xCord,
  }) : super(key: key);

  final double xCord;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(xCord, 1),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xfff75597d),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xfff235784),
                ),
              ),
            ],
          )),
    );
  }
}
