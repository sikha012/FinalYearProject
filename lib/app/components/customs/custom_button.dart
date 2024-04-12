import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? disableBorder;
  final bool? isDisabled;
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.labelStyle,
    this.width,
    this.height,
    this.padding,
    this.disableBorder = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      mouseCursor: MaterialStateMouseCursor.clickable,
      onTap: !isDisabled! ? onPressed : () {},
      child: Container(
        width: width ?? 300,
        height: height ?? 50,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: disableBorder! ? Colors.transparent : Colors.white,
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
          color: isDisabled! ? Colors.grey : color ?? const Color(0xFFFFA500),
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
