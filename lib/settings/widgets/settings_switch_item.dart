import 'package:flutter/material.dart';

class SettingsSwitchItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  const SettingsSwitchItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF2C3E50),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.black,
            activeTrackColor: Colors.blueGrey,
            inactiveThumbColor: Colors.grey,
          ),
        ],
      ),
    );

    if (onTap != null) {
      child = InkWell(
        onTap: onTap,
        child: child,
      );
    }

    return child;
  }
}
