import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final IconData prefixIcon;
  final TextEditingController? textEditingController;
  final String hintText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.subTitleColor,
          fontSize: 14,
          fontFamily: "Poppins",
        ),
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: AppColors.subTitleColor,
      ),
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
        fontSize: 14,
        fontFamily: "Poppins",
      ),
    );
  }
}
