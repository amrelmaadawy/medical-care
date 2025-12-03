import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/history/view/history_view.dart';
import 'package:medical_care/features/home/view/home_view.dart';
import 'package:medical_care/features/reminder/view/reminder_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeView(),
    HistoryView(),
    ReminderView(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: IndexedStack(index: _currentIndex, children: _screens),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 10.h,
        child: SalomonBottomBar(
          unselectedItemColor: kSubTextColor,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_outlined, size: 6.6.sp),
              title: Text('الرئيسية', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.clock, size: 6.6.sp),
              title: Text('السجل', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.notifications_outlined, size: 6.6.sp),
              title: Text('التذكيرات', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.chat_bubble_outline, size: 6.6.sp),
              title: Text('المحادثات', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person_outline, size: 6.6.sp),
              title: Text('الملف الشخصي', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
          ],
        ),
      ),
    );
  }
}
