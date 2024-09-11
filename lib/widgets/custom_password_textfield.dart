import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/password_visibility_provider.dart';
import 'package:provider/provider.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String fieldKey;
  final IconData prefixIcon;
  final TextInputType keyboardType;

  const CustomPasswordTextField({
    super.key,
    this.textEditingController,
    required this.hintText,
    required this.fieldKey,
    required this.prefixIcon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordVisibilityProvider>(
      builder: (
        context,
        passwordVisibilityProvider,
        child,
      ) {
        return TextField(
          obscureText: passwordVisibilityProvider.isObscure(fieldKey),
          keyboardType: keyboardType,
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
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisibilityProvider.isObscure(fieldKey)
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () =>
                  passwordVisibilityProvider.toggleVisibility(fieldKey),
              color: passwordVisibilityProvider.isObscure(fieldKey)
                  ? AppColors.subTitleColor
                  : AppColors.primaryColor,
            ),
          ),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontSize: 14,
            fontFamily: "Poppins",
          ),
        );
      },
    );
  }
}
