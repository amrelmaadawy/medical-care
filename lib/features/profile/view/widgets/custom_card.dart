import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;

  final Color textColor;
  final Color iconContainerColor;
  final Color iconColor;

  const CustomCard({
    super.key,
    required this.icon,
    required this.title,
    this.textColor = Colors.black,
    this.iconContainerColor = kHghtLightBlueColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 7),
          child: Row(
            children: [
              // Icon Container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),

                  color: iconContainerColor,
                ),
                child: Icon(icon, size: 24, color: iconColor),
              ),

              SizedBox(width: 16),

              // Title Text
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Arrow Icon
              Icon(Icons.arrow_back_ios, size: 16, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
