import 'package:flutter/material.dart';

class Missile extends StatelessWidget {
  const Missile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      color: Colors.purple[200],
    );
  }
}
