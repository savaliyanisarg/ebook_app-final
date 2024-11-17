import 'package:flutter/material.dart';
import '../models/book.dart'; // Assuming you have a Book model for your books
import 'book_details_screen.dart'; // Import BookDetailsScreen


class ExploreScreen extends StatelessWidget {
  final List<Book> allBooks = [
    Book(
      title: 'Science and technology',
      description: 'Science and technology',
      category: 'Fiction',
      imagePath: 'Assets/Images/eimage1.jpeg',
      pdfPath: 'Assets/pdf/Week 1.pdf',
    ),
    Book(
      title: 'Computing and technology Ethics',
      description: 'Computing and technology Ethics',
      category: 'Science',
      imagePath: 'Assets/Images/eimage2.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'World History',
      description: 'World History',
      category: 'History',
      imagePath: 'Assets/Images/eimage3.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'My india',
      description: 'My india',
      category: 'Fantasy',
      imagePath: 'Assets/Images/eimage4.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Styagrah in south Afrika',
      description: 'Styagrah in south Afrika',
      category: 'Romance',
      imagePath: 'Assets/Images/eimage5.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Burning Sky',
      description: 'Kite Runner',
      category: 'Technology',
      imagePath: 'Assets/Images/eimage6.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Kite Runner',
      description: 'Description of book 7',
      category: 'Fiction',
      imagePath: 'Assets/Images/eimage7.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'William Dalrymple',
      description: 'William Dalrymple',
      category: 'Science',
      imagePath: 'Assets/Images/eimage8.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Maharana Pratap',
      description: 'Maharana Pratap',
      category: 'History',
      imagePath: 'Assets/Images/eimage9.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Jasini Rani Laksmi bai',
      description: 'Jasini Rani Laksmi bai',
      category: 'Fantasy',
      imagePath: 'Assets/Images/eimage10.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Effective Cybercecurity',
      description: 'Effective Cybercecurity',
      category: 'Romance',
      imagePath: 'Assets/Images/eimage11.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
    Book(
      title: 'Calculating star',
      description: 'Calculating star',
      category: 'Technology',
      imagePath: 'Assets/Images/himage1.jpeg',
      pdfPath: 'Assets/PDFs/calculating_stars.pdf',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on the screen width
    int getCrossAxisCount() {
      if (screenWidth >= 1200) {
        return 5; // Desktop / large tablet
      } else if (screenWidth >= 900) {
        return 4; // Medium tablet
      } else if (screenWidth >= 600) {
        return 3; // Small tablet / large phone
      } else {
        return 2; // Small phone
      }
    }

    // Responsive text scaling based on device's text scale factor
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Calculate image height and aspect ratio based on screen size
    double getImageHeight() {
      if (screenWidth >= 1200) return 250;
      if (screenWidth >= 900) return 230;
      if (screenWidth >= 600) return 220;
      return 200; // Default for small devices
    }

    double getTitleFontSize() {
      if (screenWidth >= 1200) return 18 * textScaleFactor;
      if (screenWidth >= 900) return 16 * textScaleFactor;
      if (screenWidth >= 600) return 15 * textScaleFactor;
      return 14 * textScaleFactor; // Default for smaller devices
    }

    double getDescriptionFontSize() {
      if (screenWidth >= 1200) return 16 * textScaleFactor;
      if (screenWidth >= 900) return 14 * textScaleFactor;
      if (screenWidth >= 600) return 13 * textScaleFactor;
      return 12 * textScaleFactor; // Default for smaller devices
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
        title: SizedBox.shrink(), // Remove title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getCrossAxisCount(),
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Adjusted aspect ratio
          ),
          itemCount: allBooks.length,
          itemBuilder: (context, index) {
            return _buildBookCard(
              context,
              allBooks[index],
              getImageHeight(),
              getTitleFontSize(),
              getDescriptionFontSize(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookCard(
    BuildContext context,
    Book book,
    double imageHeight,
    double titleFontSize,
    double descriptionFontSize,
  ) {
    return InkWell(
      onTap: () {
        // Navigate to the book details screen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(book: book),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                book.imagePath,
                height: imageHeight, // Responsive image height
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Title
                    Flexible(
                      child: Text(
                        book.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize, // Responsive title font size
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    // Book Description
                    Flexible(
                      child: Text(
                        book.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize:
                              descriptionFontSize, // Responsive description font size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}