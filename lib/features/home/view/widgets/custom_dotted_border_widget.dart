import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class CustomDottedBorderWidget extends StatelessWidget {
  const CustomDottedBorderWidget({super.key, required this.child, this.onTap});
  final Widget child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefBorderRadius),
        ),
        width: double.infinity,
        height: 20.h,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: kPrimryColor,
            dashPattern: [10, 5],
            strokeWidth: 2,
            padding: EdgeInsets.all(16),
            radius: Radius.circular(kDefBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
