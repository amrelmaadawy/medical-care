import 'package:flutter/material.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class CustomPopMenuButton extends StatefulWidget {
  const CustomPopMenuButton({
    super.key,
    required this.title,
    this.onSelected,
    required this.options,
  });

  final String title;
  final PopupMenuItemSelected<String?>? onSelected;
  final List<String> options;

  @override
  State<CustomPopMenuButton> createState() => _CustomPopMenuButtonState();
}

class _CustomPopMenuButtonState extends State<CustomPopMenuButton> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth >= 1024;
        bool isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;

        double fontSize = isWeb ? 18 : (isLandscape ? 14 : 4.sp);
        double iconSize = isWeb ? 24 : (isLandscape ? 20 : 20);

        return PopupMenuButton<String?>(
          color: Colors.white,
          onSelected: (value) {
            setState(() {
              selectedValue = value;
            });
            if (widget.onSelected != null) {
              widget.onSelected!(value);
            }
          },
          itemBuilder: (context) {
            return widget.options.map((option) {
              return PopupMenuItem<String>(value: option, child: Text(option));
            }).toList();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kgreyColor),
              borderRadius: BorderRadius.circular(kDefBorderRadius),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? 12 : (isLandscape ? 10 : 8),
                vertical: isWeb ? 8 : (isLandscape ? 6 : 5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_downward, size: iconSize),
                  SizedBox(width: isWeb ? 8 : (isLandscape ? 6 : 4)),
                  Text(
                    selectedValue ?? widget.title,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
