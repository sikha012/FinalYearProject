import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final bool isDate;

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
    this.isDate = false,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  var isObscured = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 45,
      child: TextFormField(
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        cursorColor: widget.cursorColor ?? Colors.grey,
        cursorHeight: widget.cursorHeight ?? 22,
        cursorOpacityAnimates: true,
        obscureText: widget.isPassword! ? !isObscured : false,
        style: widget.textStyle ??
            const TextStyle(
              color: Colors.black,
            ),
        readOnly: widget.isDate,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
          label: Text(
            widget.label,
            style: widget.labelStyle ??
                const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.5,
                ),
          ),
          suffixIcon: widget.isDate
              ? GestureDetector(
                  onTap: () => _selectDate(context),
                  child: const Icon(Icons.calendar_today, color: Colors.grey),
                )
              : widget.suffixIcon != null
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
        onTap: widget.isDate ? () => _selectDate(context) : null,
      ),
    );
  }
}
