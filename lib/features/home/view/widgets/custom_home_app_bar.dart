import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/pref_helper.dart';

class CustomHomeAppBar extends StatefulWidget {
  const CustomHomeAppBar({super.key});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await PrefHelper.getName();
    if (mounted && name != null) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 6.sp,
          backgroundColor: kPrimryColor,
          child: Icon(
            Icons.health_and_safety_outlined,
            color: Colors.white,
            size: 7.sp,
          ),
        ),
        SizedBox(width: 3.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحبا ',
              style: TextStyle(
                color: kSubTextColor,
                fontSize: 4.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              _userName.isNotEmpty ? _userName : 'المستخدم',
              style: TextStyle(
                fontSize: 4.sp,
                color: kTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
