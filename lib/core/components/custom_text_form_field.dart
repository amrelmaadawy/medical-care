import 'package:flutter/material.dart';

import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.text,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String text;
  final String labelText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width >= 1024;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text == ''
            ? SizedBox()
            : Text(
                text,
                style: TextStyle(
                  fontSize: isWeb ? 20 : 4.sp,
                  fontWeight: FontWeight.w600,
                  color: kSubTextColor,
                ),
              ),
        SizedBox(height: isWeb ? 20 : 1.5.h),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          cursorColor: kPrimryColor,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: labelText,
            labelStyle: TextStyle(fontSize: isWeb ? 18 : 3.5.sp),
            filled: true,
            fillColor: kgreyHighlightColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isWeb ? 16 : 1.5.sp,
              vertical: isWeb ? 16 : 1.5.sp,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefBorderRadius),
              borderSide: BorderSide(color: kSubTextColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kDefBorderRadius),
              borderSide: BorderSide(color: kSubTextColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kSubTextColor),

              borderRadius: BorderRadius.circular(kDefBorderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
