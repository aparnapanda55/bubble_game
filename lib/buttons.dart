import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: Colors.blue,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(iconData),
        color: Colors.white,
      ),
    );
  }
}
