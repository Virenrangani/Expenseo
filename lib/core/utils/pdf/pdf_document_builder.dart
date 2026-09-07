import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

abstract class PdfDocumentBuilder {
  String get fileName;

  Future<Uint8List> build();

  pw.Widget buildHeader(pw.Context context);
  List<pw.Widget> buildContent(pw.Context context);
  pw.Widget buildFooter(pw.Context context);
}
