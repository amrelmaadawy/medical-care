import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/components/custom_pop_menu_button.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/helper/time_servcies.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController notesController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0XFFf2f8ff),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'اضافة تذكير جديد',
          style: TextStyle(fontSize: 5.sp, color: kTextColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefPadding),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefBorderRadius),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(kDefPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'بيانات التذكير',
                        style: TextStyle(fontSize: 5.sp, color: kPrimryColor),
                      ),
                      SizedBox(height: 2.h),

                      CustomTextFormField(
                        controller: titleController,
                        text: 'عنوان التذكير',
                        labelText: 'مثال: اسبرين 100 ملغ',
                        validator: (v) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap: () =>
                            TimeService.pickDate(context, dateController),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: dateController,
                            text: 'التاريخ  ',
                            labelText: 'التاريخ ',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك ادخل  التاريخ ';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      GestureDetector(
                        onTap: () => TimeService.pickTime(context, (v) {}),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            controller: timeController,
                            text: 'وقت التذكير',
                            labelText: ' وقت التذكير',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك ادخل وقت التذكير';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      SizedBox(
                        height: 6.h,
                        width: 90.w,
                        child: CustomPopMenuButton(
                          title: 'التكرار',
                          options: ['سنوي', 'شهري', 'اسبوعي', 'يومي'],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      CustomTextFormField(
                        controller: notesController,
                        text: 'ملاحظات (اختياري)',
                        labelText: 'اضف ملاحظات اضافيه',
                        validator: (v) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 4.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomElevatedButton(
                            widget: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 5.sp,
                            ),
                            text: 'حفظ',
                            borderColor: kPrimryColor,
                            buttonColor: kPrimryColor,
                            textColor: Colors.white,
                            width: 40.w,
                            onPressed: () {},
                          ),

                          CustomElevatedButton(
                            widget: Icon(
                              Icons.close,
                              color: kRedColor,
                              size: 5.sp,
                            ),

                            text: 'الغاء',
                            borderColor: kHghtLightRedColor,
                            buttonColor: Colors.white,
                            textColor: kRedColor,
                            width: 40.w,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
