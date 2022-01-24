import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 50,
      decoration: const BoxDecoration(
        color: Colors.purple,
      ),
    );
  }
}
