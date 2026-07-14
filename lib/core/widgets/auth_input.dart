import 'package:flutter/material.dart';
import '../constants.dart';

class AuthInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextInputType inputType;

  const AuthInput({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
            color: AppColors.border
        )),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.border),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary, width: 2.0 ),
            ),
          ),
        ),
      ],
    );
  }
}