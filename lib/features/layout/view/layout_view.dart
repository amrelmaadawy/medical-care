import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
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
    Container(child: Text(' و قال له تعالي ادلعك يا ابن عمي و هوريك الي عمرك ما شوفته',style: TextStyle(fontSize: 10.sp),),),
    Container(),
    Container(),
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
          unselectedItemColor: kPrimryColor,
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
              icon: Icon(Icons.assignment_outlined, size: 6.6.sp),
              title: Text('السجل', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.shopping_basket_outlined, size: 6.6.sp),
              title: Text('التذكيرات', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_border_outlined, size: 6.6.sp),
              title: Text('المحادثات', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.menu, size: 6.6.sp),
              title: Text('الملف الشخصي', style: TextStyle(fontSize: 3.5.sp)),
              selectedColor: kPrimryColor,
            ),
          ],
        ),
      ),
    );
  }
}
