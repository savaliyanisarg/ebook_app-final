import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfViewScreen extends StatefulWidget {
  final String pdfPath; // The path to the PDF file (assets/local/URL).

  PdfViewScreen({required this.pdfPath});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? localPdfPath; // The path to the locally stored PDF file.
  bool isLoading = true; // Track loading state.

  @override
  void initState() {
    super.initState();
    _loadPdf(); // Start loading the PDF file on initialization.
  }

  // Load the PDF from assets, local storage, or a URL.
  Future<void> _loadPdf() async {
    try {
      if (widget.pdfPath.startsWith('assets/')) {
        // Handle assets PDF
        final byteData = await rootBundle.load(widget.pdfPath);
        final file = File('${(await getTemporaryDirectory()).path}/temp.pdf');
        await file.writeAsBytes(byteData.buffer.asUint8List());
        setState(() {
          localPdfPath = file.path;
          isLoading = false;
        });
      } else if (widget.pdfPath.startsWith('http')) {
        // Handle remote URL (Download and save locally)
        final fileName = widget.pdfPath.split('/').last;
        final file = File('${(await getTemporaryDirectory()).path}/$fileName');
        if (!await file.exists()) {
          // Download the file if not already downloaded
          final httpClient = HttpClient();
          final request = await httpClient.getUrl(Uri.parse(widget.pdfPath));
          final response = await request.close();
          final bytes = await consolidateHttpClientResponseBytes(response);
          await file.writeAsBytes(bytes);
        }
        setState(() {
          localPdfPath = file.path;
          isLoading = false;
        });
      } else {
        // Assume it's a local file path
        setState(() {
          localPdfPath = widget.pdfPath;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Book Viewer'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : localPdfPath == null
              ? Center(
                  child: Text(
                    'Failed to load PDF',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                )
              : PDFView(
                  filePath: localPdfPath!,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error loading PDF: $error')),
                    );
                  },
                  onPageError: (page, error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error on page $page: $error')),
                    );
                  },
                ),
    );
  }
}
