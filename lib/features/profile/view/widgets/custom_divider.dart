import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double width;

  const CustomDivider({
    super.key,
    this.height = 1,
    this.color = const Color(0xffF5F5F5),
    this.width = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width),
      child: Divider(height: height, color: color),
    );
  }
}
