import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool? enabled;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;

  CustomTextField({
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.obsecureText = false,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.enabled,
    this.suffixIcon,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        readOnly: readOnly,
        obscureText: obsecureText,
        validator: validator,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon:
              GestureDetector(onTap: onSuffixIconTap, child: Icon(suffixIcon)),
          hintText: hintText,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
        ),
      ),
    );
  }
}
