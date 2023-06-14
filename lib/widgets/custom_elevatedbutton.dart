import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String imagePath;

  const CustomElevatedButton({
    required this.onPressed,
    required this.buttonText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 120,
            height: 120,
          ),
          SizedBox(height: 8),
          Text(
            buttonText,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
