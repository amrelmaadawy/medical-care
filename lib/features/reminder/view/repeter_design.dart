// Card(
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(kDefBorderRadius),
//   ),
//   color: Colors.white,
//   child: Padding(
//     padding: const EdgeInsets.all(kDefPadding),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'قواعد التكرار',
//           style: TextStyle(fontSize: 5.sp, color: kPrimryColor),
//         ),
//         SizedBox(height: 2.h),
//         Card(
//           elevation: 0,

//           color: Color(0XFFecfeff),
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Color(0XFFa2f4fd)),
//             borderRadius: BorderRadiusGeometry.circular(
//               kDefBorderRadius,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(kDefPadding),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     CustomPopMenuButton(
//                       title: 'التكرار',
//                       options: ['سنوي', 'شهري', 'اسبوعي', 'يومي'],
//                     ),
//                     Spacer(),
//                     NumberPickerField(),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () =>
//                       TimeService.pickTime(context, (v) {}),
//                   child: AbsorbPointer(
//                     child: CustomTextFormField(
//                       controller: timeController,
//                       text: 'وقت التذكير',
//                       labelText: ' وقت التذكير',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'من فضلك ادخل وقت التذكير';
//                         }
//                         return null;
//                       },
//                       keyboardType: TextInputType.datetime,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: 35.w,
//                       child: GestureDetector(
//                         onTap: () => TimeService.pickDate(
//                           context,
//                           startDateController,
//                         ),
//                         child: AbsorbPointer(
//                           child: CustomTextFormField(
//                             controller: startDateController,
//                             text: 'تاريخ البدء ',
//                             labelText: ' تاريخ البدء',
//                             validator: (value) {
//                               if (value == null ||
//                                   value.isEmpty) {
//                                 return 'من فضلك ادخل تاريخ البداية';
//                               }
//                               return null;
//                             },
//                             keyboardType: TextInputType.datetime,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 35.w,
//                       child: GestureDetector(
//                         onTap: () => TimeService.pickDate(
//                           context,
//                           endDateController,
//                         ),
//                         child: AbsorbPointer(
//                           child: CustomTextFormField(
//                             controller: endDateController,
//                             text: 'تاريخ الانتهاء ',
//                             labelText: 'تاريخ الانتهاء',
//                             validator: (value) {
//                               if (value == null ||
//                                   value.isEmpty) {
//                                 return 'من فضلك ادخل  تاريخ الانتهاء';
//                               }
//                               return null;
//                             },
//                             keyboardType: TextInputType.datetime,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 2.h),
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: 35.w,
//                       child: CustomElevatedButton(
//                         borderColor: Color(0XFFecfeff),
//                         textColor: Colors.white,
//                         buttonColor: kPrimryColor,
//                         text: 'حفظ القاعده',
//                         onPressed: () {},
//                       ),
//                     ),
//                     SizedBox(
//                       width: 35.w,
//                       child: CustomElevatedButton(
//                         borderColor: Color(0XFFecfeff),
//                         textColor: Colors.white,
//                         buttonColor: kRedColor,
//                         text: 'الغاء',
//                         onPressed: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 2.h),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 kDefBorderRadius,
//               ),
//             ),
//             width: double.infinity,
//             height: 6.h,

//             child: DottedBorder(
//               options: RectDottedBorderOptions(
//                 color: kPrimryColor,
//                 dashPattern: [5, 3],
//                 strokeWidth: 1.5,
//                 padding: EdgeInsets.all(10),
//               ),
//               child: Center(
//                 child: Text(
//                   '+ اضافه قاعده تكراريه',
//                   style: TextStyle(
//                     fontSize: 4.sp,
//                     color: kTextColor,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),

// Card(
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(kDefBorderRadius),
//   ),
//   color: Colors.white,
//   child: Padding(
//     padding: const EdgeInsets.all(kDefPadding),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'الاستثناءات',
//           style: TextStyle(fontSize: 5.sp, color: kPrimryColor),
//         ),
//         SizedBox(height: 2.h),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 kDefBorderRadius,
//               ),
//             ),
//             width: double.infinity,
//             height: 6.h,

//             child: DottedBorder(
//               options: RectDottedBorderOptions(
//                 color: kPrimryColor,
//                 dashPattern: [5, 3],
//                 strokeWidth: 1.5,
//                 padding: EdgeInsets.all(10),
//               ),
//               child: Center(
//                 child: Text(
//                   '+ اضافه استثناء ',
//                   style: TextStyle(
//                     fontSize: 4.sp,
//                     color: kTextColor,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
