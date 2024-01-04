import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final double? cursorHeight;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isPassword;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconPress;
  final TextInputAction? textInputAction;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.labelStyle,
    this.textStyle,
    this.cursorColor,
    this.cursorHeight,
    this.contentPadding,
    this.isPassword = false,
    this.suffixIcon,
    this.onSuffixIconPress,
    this.textInputAction,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  var isObscured = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        textInputAction: widget.textInputAction,
        cursorColor: widget.cursorColor ?? Colors.grey,
        cursorHeight: widget.cursorHeight ?? 22,
        cursorOpacityAnimates: true,
        obscureText: widget.isPassword! ? !isObscured : false,
        style: widget.textStyle ??
            const TextStyle(
              color: Colors.white,
            ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 18,
              ),
          label: Text(
            widget.label,
            style: widget.labelStyle ??
                const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: widget.onSuffixIconPress,
                  child: widget.suffixIcon,
                )
              : widget.isPassword!
                  ? GestureDetector(
                      child: Icon(
                        isObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
