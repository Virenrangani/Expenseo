import 'dart:typed_data';

import 'package:printing/printing.dart';

import 'pdf_document_builder.dart';

class PdfService {
  const PdfService._();

  static Future<Uint8List> generate(PdfDocumentBuilder builder) {
    return builder.build();
  }

  static Future<void> share(PdfDocumentBuilder builder) async {
    final bytes = await builder.build();
    final sanitizedFileName = '${_sanitizeFileName(builder.fileName)}.pdf';

    await Printing.sharePdf(bytes: bytes, filename: sanitizedFileName);
  }

  static Future<void> previewOrPrint(PdfDocumentBuilder builder) async {
    final sanitizedFileName = '${_sanitizeFileName(builder.fileName)}.pdf';

    await Printing.layoutPdf(
      name: sanitizedFileName,
      onLayout: (format) => builder.build(),
    );
  }

  static String _sanitizeFileName(String name) {
    return name
        .trim()
        .replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_')
        .replaceAll(RegExp('_+'), '_');
  }
}
