class Book {
  final String title;
  final String description;
  final String category;
  final String imagePath;
  final bool isPopular;
  final String pdfPath; // Add this field for the PDF file path
  bool isFavorite;

  Book({
    required this.title,
    required this.description,
    required this.category,
    required this.imagePath,
    this.isPopular = false,
    required this.pdfPath, // Make it a required field
    this.isFavorite = false,
  });
}
