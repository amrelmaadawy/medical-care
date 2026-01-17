import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:medical_care/features/history/model/assessments/assessment.dart';

class PdfGenerator {
  static Future<void> generateAndPrint(Assessment assessment) async {
    final pdf = pw.Document();

    // Load fonts (assuming Cairo is used in the app, we need a ttf for PDF)
    // We'll use a standard font if custom one fails or for simplicity in this MVP step,
    // but ideally we load 'assets/fonts/Cairo-Regular.ttf'.
    // For now, let's try to load the font if accessible, otherwise fallback.
    pw.Font? arabicFont;
    try {
      final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
      arabicFont = pw.Font.ttf(fontData);
    } catch (e) {
      // Fallback if font not found, though Arabic might not render correctly without it.
      print("Error loading font: $e");
    }

    final theme = pw.ThemeData.withFont(base: arabicFont);

    pdf.addPage(
      pw.Page(
        theme: theme,
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(assessment),
              pw.SizedBox(height: 20),
              _buildRiskSection(assessment),
              pw.SizedBox(height: 20),
              _buildDetailsSection(assessment),
              pw.SizedBox(height: 20),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Medical_Report_${assessment.id}.pdf',
    );
  }

  static pw.Widget _buildHeader(Assessment assessment) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
        ),
      ),
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'تقرير طبي',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'تاريخ: ${assessment.createdAt?.substring(0, 10) ?? "N/A"}',
                style: pw.TextStyle(color: PdfColors.grey700),
              ),
              pw.Text(
                'رقم السجل: #${assessment.id}',
                style: pw.TextStyle(color: PdfColors.grey700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRiskSection(Assessment assessment) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'مستوى الخطورة',
                style: pw.TextStyle(fontSize: 16, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                '${assessment.riskPercentage ?? 0}%',
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                  color: (assessment.riskPercentage ?? 0) > 50
                      ? PdfColors.red
                      : PdfColors.green,
                ),
              ),
            ],
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: pw.BoxDecoration(
              color: (assessment.riskPercentage ?? 0) > 50
                  ? PdfColors.red100
                  : PdfColors.green100,
              borderRadius: pw.BorderRadius.circular(20),
            ),
            child: pw.Text(
              (assessment.riskPercentage ?? 0) > 50 ? 'خطر مرتفع' : 'منخفض',
              style: pw.TextStyle(
                color: (assessment.riskPercentage ?? 0) > 50
                    ? PdfColors.red800
                    : PdfColors.green800,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildDetailsSection(Assessment assessment) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('التشخيص'),
        pw.Text(
          assessment.reason ?? 'لا يوجد تشخيص محدد',
          style: pw.TextStyle(fontSize: 14),
        ),
        pw.SizedBox(height: 15),

        _buildSectionTitle('الأعراض المسجلة'),
        if (assessment.symptomsSelected != null &&
            assessment.symptomsSelected!.isNotEmpty)
          ...assessment.symptomsSelected!
              .map(
                (s) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(2),
                        ),
                        width: 4,
                        height: 4,
                        color: PdfColors.black,
                      ),
                      pw.SizedBox(width: 6),
                      pw.Text(s.name ?? '', style: pw.TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              )
              .toList()
        else
          pw.Text(
            'لا توجد أعراض مسجلة',
            style: pw.TextStyle(fontSize: 14, color: PdfColors.grey600),
          ),

        pw.SizedBox(height: 15),
        _buildSectionTitle('التوصيات'),
        pw.Text(
          assessment.recommendation ?? 'يرجى مراجعة الطبيب للمتابعة.',
          style: pw.TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  static pw.Widget _buildSectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue800,
        ),
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            'تم إنشاء هذا التقرير تلقائياً بواسطة تطبيق الرعاية الطبية',
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
          ),
        ),
      ],
    );
  }
}
