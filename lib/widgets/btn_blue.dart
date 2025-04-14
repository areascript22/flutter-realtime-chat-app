import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final void Function()? onPressed;
  const BlueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(15),
        elevation: 5,
      ),
      child: Center(
        child: Text(
          "Ingrese",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
