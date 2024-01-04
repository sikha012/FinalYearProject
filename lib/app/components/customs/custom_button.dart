import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 300,
        height: height ?? 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurStyle: BlurStyle.inner,
              blurRadius: 25,
            ),
          ],
          color: const Color(0xFFFFA500),
        ),
        child: Center(
          child: Text(
            label,
            style: labelStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
          ),
        ),
      ),
    );
  }
}
