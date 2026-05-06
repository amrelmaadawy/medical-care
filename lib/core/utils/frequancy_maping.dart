final Map<String, String> recurrenceMap = {
  'يومي': 'daily',
  'اسبوعي': 'weekly',
  'شهري': 'monthly',
  'سنوي': 'yearly',
};

// إنشاء الخريطة العكسية
final Map<String, String> recurrenceMapAr = recurrenceMap.map(
  (key, value) => MapEntry(value, key),
);

// الدالة المطلوبة

String getRecurrenceArabic(String englishValue) {
  // .toLowerCase() لضمان البحث بشكل صحيح مهما كانت حالة الأحرف
  return recurrenceMapAr[englishValue.toLowerCase()] ?? englishValue; 
  // إذا لم يجد القيمة، سيعيد الكلمة الإنجليزية كما هي
}