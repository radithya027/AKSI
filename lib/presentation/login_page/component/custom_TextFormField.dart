import 'package:flutter/material.dart';
import '../../../infrastructure/theme/theme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.onChanged,
    required this.controller,
    this.validator, // Add validator here
  });

  final String labelText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator function

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      maxLines: widget.isPassword ? 1 : null,
      style: AppTextStyle.tsBodyRegular(Primary.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Primary.grey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Primary.blue500),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Primary.blue500),
        ),
        fillColor: Primary.white,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Primary.black,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: AppTextStyle.tsSmallRegular(Primary.black),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator, // Add validator here
    );
  }
}
