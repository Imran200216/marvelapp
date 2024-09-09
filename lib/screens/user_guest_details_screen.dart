import 'package:flutter/material.dart';

class UserGuestDetailsScreen extends StatelessWidget {
  const UserGuestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 30,
          ),
        ),
      ),
    );
  }
}
