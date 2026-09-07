import 'package:flutter/material.dart';

import '../../constant/gap/app_gap.dart';
import 'pdf_document_builder.dart';
import 'pdf_service.dart';

class PdfExportBottomSheet extends StatelessWidget {
  final PdfDocumentBuilder builder;

  const PdfExportBottomSheet({super.key, required this.builder});

  static Future<void> show(BuildContext context, PdfDocumentBuilder builder) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => PdfExportBottomSheet(builder: builder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Export Statement',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            AppGap.g12,
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.share_rounded, color: Colors.blue.shade700),
              ),
              title: const Text('Share PDF File'),
              subtitle: const Text('Send via WhatsApp, Email, or Slack'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await PdfService.share(builder);
              },
            ),
            AppGap.g8,
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.print_rounded,
                  color: Color(0xFF047857),
                ),
              ),
              title: const Text('Preview or Save to Device'),
              subtitle: const Text('Print or download locally as a PDF'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await PdfService.previewOrPrint(builder);
              },
            ),
          ],
        ),
      ),
    );
  }
}
