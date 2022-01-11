import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final icon;
  final function;
  const MyButton({required this.icon, required this.function, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.white,
          child: Icon(
            icon,
            size: 30,
          ),
        ),
      ),
    );
  }
}
