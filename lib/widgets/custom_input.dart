import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    super.key,
    required this.icon,
    required this.placeHolder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeHolder,
        ),
      ),
    );
  }
}
