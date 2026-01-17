import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class DoctorItem extends StatelessWidget {
  final String name;
  final String specialty;
  final String status;
  final String time;
  final Color avatarColor;
  final VoidCallback? onTap;

  const DoctorItem({
    super.key,
    required this.name,
    required this.specialty,
    required this.status,
    required this.time,
    this.avatarColor = kLightBlueColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kgreyHighlightColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Doctor Avatar
                CircleAvatar(
                  radius: 30,
                  backgroundColor: avatarColor,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),

                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            time,
                            style: TextStyle(
                              color: kSubTextColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        specialty,
                        style: TextStyle(color: kSubTextColor, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        status,
                        style: TextStyle(color: kSubTextColor, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
