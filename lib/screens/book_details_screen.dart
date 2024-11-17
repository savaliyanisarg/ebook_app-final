import 'dart:io';

import 'package:flutter/material.dart';
import '../models/book.dart';
import 'package:ebook_app/screens/pdf_view_screen.dart'; // Import the PDF view screen
import 'package:dio/dio.dart'; // For downloading files
import 'package:path_provider/path_provider.dart'; // For file storage

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({required this.book});

  // Function to download the PDF
  Future<void> _downloadBook(BuildContext context) async {
    try {
      // Create Dio instance for downloading the file
      Dio dio = Dio();
      
      // Get the directory to save the downloaded file
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = '${appDocDir.path}/${book.title}.pdf';

      // Download the PDF file
      await dio.download(book.pdfPath, savePath);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Downloaded ${book.title} to $savePath'),
      ));
    } catch (e) {
      // If an error occurs during download
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to download ${book.title}: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the book image
            Center(
              child: Image.asset(
                book.imagePath, // Path to the book image
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Book Title
            Text(
              book.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Book Description
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Read Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the PDF view screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewScreen(
                            pdfPath: book.pdfPath, // Provide the path to the PDF
                          ),
                        ),
                      );
                    },
                    child: Text('Read'),
                  ),
                ),

                SizedBox(width: 10), // Space between buttons

                // Download Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the download function when "Download" is pressed
                      _downloadBook(context);
                    },
                    child: Text('Download'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
