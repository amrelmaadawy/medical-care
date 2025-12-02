import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.widget,
    required this.text,
    this.onPressed,
    this.width,
    this.borderColor,
    this.textColor,
  });
  final Widget? widget;
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? kPrimryColor),
        borderRadius: BorderRadius.circular(kDefBorderRadius),
      ),
      width: width ?? double.infinity,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(kDefBorderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 3.5.sp),
              ),

              SizedBox(child: widget),
            ],
          ),
        ),
      ),
    );
  }
}
