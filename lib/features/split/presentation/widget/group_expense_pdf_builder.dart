import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/utils/pdf/pdf_document_builder.dart';
import '../../../../core/utils/pdf/pdf_theme.dart';
import '../../domain/entity/split_entity.dart';

class GroupExpensePdfBuilder implements PdfDocumentBuilder {
  final String groupName;
  final List<SplitEntity> expenses;
  final DateFormat _dateFormatter = DateFormat('dd MMM yyyy, hh:mm a');

  GroupExpensePdfBuilder({required this.groupName, required this.expenses});

  @override
  String get fileName => '${groupName}_Expense_Report';

  @override
  Future<Uint8List> build() async {
    final pdf = pw.Document();

    // 1. Fetch Unicode-safe fonts dynamically from printing package
    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    // 2. Apply theme with full Unicode character support
    final theme = pw.ThemeData.withFont(base: fontRegular, bold: fontBold);

    pdf.addPage(
      pw.MultiPage(
        theme: theme,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        header: buildHeader,
        footer: buildFooter,
        build: buildContent,
      ),
    );

    return pdf.save();
  }

  @override
  pw.Widget buildHeader(pw.Context context) {
    final double total = expenses.fold(0, (sum, e) => sum + e.amount);

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('EXPENSEO', style: AppPdfTheme.headingLarge),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    'Group Expense Audit Statement',
                    style: AppPdfTheme.bodySecondary,
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Generated on: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                    style: AppPdfTheme.caption,
                  ),
                  pw.Text(
                    'Time: ${DateFormat('hh:mm a').format(DateTime.now())}',
                    style: AppPdfTheme.caption,
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            decoration: pw.BoxDecoration(
              color: AppPdfTheme.surface,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: AppPdfTheme.border),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Group: ', style: AppPdfTheme.bodySecondary),
                    pw.Text(groupName, style: AppPdfTheme.headingMedium),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'Total Expenditure: ',
                      style: AppPdfTheme.bodySecondary,
                    ),
                    pw.Text(
                      'INR ${total.toStringAsFixed(2)}',
                      style: AppPdfTheme.headingMedium.copyWith(
                        color: AppPdfTheme.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  List<pw.Widget> buildContent(pw.Context context) {
    return [
      _buildMemberBreakdown(),
      pw.SizedBox(height: 20),
      pw.Text('Itemized Transaction Records', style: AppPdfTheme.headingMedium),
      pw.SizedBox(height: 8),
      _buildTransactionTable(),
    ];
  }

  @override
  pw.Widget buildFooter(pw.Context context) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: AppPdfTheme.border)),
      ),
      padding: const pw.EdgeInsets.only(top: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          // Use standard hyphen instead of em-dash if needed
          pw.Text(
            'Confidential - Expenseo Financial Services',
            style: AppPdfTheme.caption,
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: AppPdfTheme.caption,
          ),
        ],
      ),
    );
  }

  pw.Widget _buildMemberBreakdown() {
    final Map<String, double> userTotals = {};
    for (final e in expenses) {
      userTotals[e.paidByName] = (userTotals[e.paidByName] ?? 0) + e.amount;
    }

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: AppPdfTheme.surface,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: AppPdfTheme.border),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Member Contribution Overview',
            style: AppPdfTheme.bodySecondary,
          ),
          pw.SizedBox(height: 8),
          pw.Wrap(
            spacing: 24,
            runSpacing: 6,
            children: userTotals.entries.map((entry) {
              return pw.RichText(
                text: pw.TextSpan(
                  text: '${entry.key}: ',
                  style: AppPdfTheme.bodyRegular,
                  children: [
                    pw.TextSpan(
                      text: 'INR ${entry.value.toStringAsFixed(2)}',
                      style: AppPdfTheme.bodyRegular.copyWith(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildTransactionTable() {
    final headers = ['Date', 'Description', 'Paid By', 'Amount (INR)'];

    final rows = expenses.map((e) {
      return [
        _dateFormatter.format(e.createdAt.toLocal()),
        e.title,
        e.paidByName,
        e.amount.toStringAsFixed(2),
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: rows,
      border: null,
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontWeight: pw.FontWeight.bold,
        fontSize: 9,
      ),
      headerDecoration: const pw.BoxDecoration(
        color: AppPdfTheme.primary,
        borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(6)),
      ),
      cellStyle: AppPdfTheme.bodyRegular,
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: AppPdfTheme.border, width: 0.5),
        ),
      ),
      cellPadding: const pw.EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
      },
    );
  }
}
