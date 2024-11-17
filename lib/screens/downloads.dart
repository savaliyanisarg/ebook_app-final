import 'package:ebook_app/screens/pdf_view_screen.dart';
import 'package:flutter/material.dart';
import '../models/book.dart'; // Ensure this points to your Book model.

class DownloadsScreen extends StatefulWidget {
  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  List<Book> downloadedBooks = [
    Book(
      title: 'Styagrah of Southafrika',
      description: 'Description of downloaded book 1',
      category: 'Fiction',
      imagePath: 'Assets/Images/eimage5.jpeg', // Ensure this image path exists
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Jasini rani laksmibai',
      description: 'Description of downloaded book 2',
      category: 'Science',
      imagePath: 'Assets/Images/eimage10.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Life in South',
      description: 'Description of downloaded book 3',
      category: 'History',
      imagePath: 'Assets/Images/himage12.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    // Add more downloaded books as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads'),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: downloadedBooks.isEmpty
          ? Center(child: Text('No downloaded ebooks found.'))
          : ListView.builder(
              itemCount: downloadedBooks.length,
              itemBuilder: (context, index) {
                final book = downloadedBooks[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: Image.asset(
                      book.imagePath,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.title),
                    subtitle: Text(book.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        // Show confirmation dialog before deleting
                        _confirmDelete(context, index);
                      },
                    ),
                    onTap: () {
                      // Navigate to a PDF viewer or book details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewScreen(pdfPath: book.pdfPath),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  // Show a confirmation dialog
  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Book'),
          content: Text('Are you sure you want to delete this book?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Delete the book and refresh the list
                setState(() {
                  downloadedBooks.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Book deleted successfully!')),
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
