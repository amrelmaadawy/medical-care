import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/components/custom_elevated_button.dart';
import 'package:medical_care/core/components/custom_pop_menu_button.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/helper/time_conver.dart';
import 'package:medical_care/core/helper/time_servcies.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/core/utils/frequancy_maping.dart';
import 'package:medical_care/features/reminder/model/reminder_model/recurrence_rule.dart';
import 'package:medical_care/features/reminder/model_view/reminder_cubit.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // مفتاح الـ Validation
  late TextEditingController titleController;
  late TextEditingController notesController;
  late TextEditingController timeController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  String? selectedRecurrence; // تم نقله خارج الـ build لضمان ثبات القيمة

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    notesController = TextEditingController();
    timeController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    timeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFf2f8ff),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'اضافة تذكير جديد',
          style: TextStyle(fontSize: 18, color: kTextColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefPadding),
          child: Form(
            key: formKey, // ربط الـ Form بالمفتاح
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
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // العنوان
                        CustomTextFormField(
                          controller: titleController,
                          text: 'عنوان التذكير',
                          labelText: 'مثال: اسبرين 100 ملغ',
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'برجاء إدخال اسم الدواء أو التذكير'
                              : null,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 2.h),

                        // تاريخ البداية
                        GestureDetector(
                          onTap: () => TimeService.pickDate(
                            context,
                            startDateController,
                          ),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              controller: startDateController,
                              text: 'تاريخ البدايه',
                              labelText: 'اختر تاريخ البدء',
                              validator: (v) => (v == null || v.isEmpty)
                                  ? 'التاريخ مطلوب'
                                  : null,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // تاريخ النهاية
                        GestureDetector(
                          onTap: () =>
                              TimeService.pickDate(context, endDateController),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              controller: endDateController,
                              text: 'تاريخ النهايه',
                              labelText: 'اختر تاريخ الانتهاء',
                              validator: (v) => (v == null || v.isEmpty)
                                  ? 'تاريخ الانتهاء مطلوب'
                                  : null,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // الوقت
                        GestureDetector(
                          onTap: () => TimeService.pickTime(
                            context,
                            (v) => timeController.text = v,
                          ),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              controller: timeController,
                              text: 'وقت التذكير',
                              labelText: 'حدد الساعة',
                              validator: (v) => (v == null || v.isEmpty)
                                  ? 'الوقت مطلوب'
                                  : null,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // التكرار
                        SizedBox(
                          width: double.infinity,
                          child: CustomPopMenuButton(
                            title: selectedRecurrence ?? 'اختر معدل التكرار',
                            options: const ['سنوي', 'شهري', 'اسبوعي', 'يومي'],
                            onSelected: (value) {
                              setState(() {
                                selectedRecurrence = value;
                              });
                            },
                          ),
                        ),
                        // رسالة خطأ بسيطة للتكرار إذا لم يتم الاختيار
                        if (selectedRecurrence == null)
                          const Padding(
                            padding: EdgeInsets.only(top: 8, right: 12),
                            child: Text(
                              'برجاء تحديد التكرار',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),

                        SizedBox(height: 2.h),

                        // ملاحظات
                        CustomTextFormField(
                          controller: notesController,
                          text: 'ملاحظات (اختياري)',
                          labelText: 'اضف ملاحظات اضافيه',
                          validator: (v) => null, // اختياري
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 4.h),

                        // الأزرار
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocConsumer<ReminderCubit, ReminderState>(
                              listener: (context, state) {
                                if (state is GetReminderSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم حفظ التذكير بنجاح',style: TextStyle(color:kGreenColor),),
                                      backgroundColor: kHghtLightGreenColor,
                                    ),
                                  );
                                  Navigator.pop(context);
                                } else if (state is GetReminderError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('خطأ: ${state.error}',style: TextStyle(color:kRedColor),),
                                      backgroundColor: kHghtLightRedColor,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return CustomElevatedButton(
                                  widget: state is GetReminderLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                  text: 'حفظ',
                                  borderColor: kPrimryColor,
                                  buttonColor: kPrimryColor,
                                  textColor: Colors.white,
                                  width: 40.w,
                                  onPressed: () {
                                    if (formKey.currentState!.validate() &&
                                        selectedRecurrence != null) {
                                      context.read<ReminderCubit>().postReminder(
                                        title: titleController.text,
                                        description: notesController.text,
                                        recurrenceRules: RecurrenceRule(
                                          frequency:
                                              recurrenceMap[selectedRecurrence],
                                          interval: 1,
                                          startDate: formatDateForApi(
                                            startDateController.text,
                                          ),
                                          endDate: formatDateForApi(
                                            endDateController.text,
                                          ),
                                          time: formatTimeForApi(
                                            timeController.text,
                                          ),
                                        ),
                                      );
                                    } else if (selectedRecurrence == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'برجاء تحديد معدل التكرار',style: TextStyle(color:kRedColor),),
                                          backgroundColor: kRedColor,
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),

                            CustomElevatedButton(
                              widget: const Icon(
                                Icons.close,
                                color: kRedColor,
                                size: 20,
                              ),
                              text: 'الغاء',
                              borderColor: kHghtLightRedColor,
                              buttonColor: Colors.white,
                              textColor: kRedColor,
                              width: 40.w,
                              onPressed: () => Navigator.pop(context),
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
      ),
    );
  }
}
