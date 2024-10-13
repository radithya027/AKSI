import 'package:aksi/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Color colorButton;
  final Color colorText;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.colorButton,
    required this.colorText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorButton),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ))),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.tsBodyBold(colorText),
        ),
      ),
    );
  }
}
