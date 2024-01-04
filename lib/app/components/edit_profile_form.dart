import 'package:flutter/material.dart';

class EditProfileForm extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final double? cursorHeight;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isPassword;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconPress;
  final TextInputAction? textInputAction;

  const EditProfileForm({
    super.key,
    required this.controller,
    this.label,
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
  State<EditProfileForm> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<EditProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label ?? '',
              style: widget.labelStyle ??
                  const TextStyle(
                    color: Color(
                      0xFF8C8C8C,
                    ),
                  ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                textAlign: TextAlign.right,
                textInputAction: widget.textInputAction,
                cursorColor: widget.cursorColor ?? Colors.grey,
                cursorHeight: widget.cursorHeight ?? 22,
                cursorOpacityAnimates: true,
                style: widget.textStyle ??
                    const TextStyle(
                      color: Color(0xFF3F3F3F),
                    ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      widget.contentPadding ?? const EdgeInsets.only(left: 50),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
