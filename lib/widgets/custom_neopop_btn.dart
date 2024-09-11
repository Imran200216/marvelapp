import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class CustomNeoPopButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String svgAssetPath;
  final String buttonText;
  final VoidCallback onTapUp;
  final VoidCallback? onTapDown;

  const CustomNeoPopButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.svgAssetPath,
    required this.buttonText,
    required this.onTapUp,
    this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    return NeoPopButton(
      color: buttonColor,
      onTapUp: onTapUp,
      onTapDown: onTapDown ?? () => HapticFeedback.vibrate(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgAssetPath,
              height: MediaQuery.of(context).size.height * 0.030,
              width: MediaQuery.of(context).size.width * 0.030,
              color: textColor,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.038,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
