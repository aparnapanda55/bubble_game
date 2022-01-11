import 'package:flutter/material.dart';

class Misile extends StatelessWidget {
  const Misile({
    Key? key,
    required this.misileY,
    required this.misileX,
    required this.misileHeight,
  }) : super(key: key);

  final double misileX;
  final double misileY;
  final double misileHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(misileX, misileY),
      child: Container(
        width: 7,
        height: misileHeight,
        color: Colors.cyan,
      ),
    );
  }
}
