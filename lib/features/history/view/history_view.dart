import 'package:flutter/material.dart';
import 'package:medical_care/core/components/custom_text_form_field.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/core/utils/app_padding.dart';
import 'package:medical_care/features/history/view/widgets/diagnosis_item.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(kDefPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سجل التشخيصات',
              style: TextStyle(color: kTextColor, fontSize: 4.sp),
            ),
            SizedBox(height: 2.h),
            CustomTextFormField(
              prefixIcon: Icon(
                Icons.search,
                size: 6.5.sp,
                color: kSubTextColor,
              ),
              controller: searchController,
              text: '',
              labelText: 'البحث في السجلات...',
              validator: (String? p1) {
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 2.h),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return DiagnosisItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
