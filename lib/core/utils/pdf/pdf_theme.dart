import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AppPdfTheme {
  const AppPdfTheme._();

  static const PdfColor primary = PdfColor.fromInt(0xFF2A5CF6);
  static const PdfColor primaryDark = PdfColor.fromInt(0xFF1E3A8A);
  static const PdfColor textPrimary = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor textSecondary = PdfColor.fromInt(0xFF475569);
  static const PdfColor textMuted = PdfColor.fromInt(0xFF94A3B8);
  static const PdfColor surface = PdfColor.fromInt(0xFFF8FAFC);
  static const PdfColor border = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor success = PdfColor.fromInt(0xFF16A34A);

  static pw.TextStyle headingLarge = pw.TextStyle(
    fontSize: 22,
    fontWeight: pw.FontWeight.bold,
    color: primaryDark,
  );

  static pw.TextStyle headingMedium = pw.TextStyle(
    fontSize: 14,
    fontWeight: pw.FontWeight.bold,
    color: textPrimary,
  );

  static pw.TextStyle bodyRegular = const pw.TextStyle(
    fontSize: 9.5,
    color: textPrimary,
  );

  static pw.TextStyle bodySecondary = const pw.TextStyle(
    fontSize: 8.5,
    color: textSecondary,
  );

  static pw.TextStyle caption = const pw.TextStyle(
    fontSize: 7.5,
    color: textMuted,
  );
}
