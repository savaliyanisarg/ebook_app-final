import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Book> favoriteBooks;
  final Function(Book) onToggleFavorite; // Callback to handle toggling favorite

  FavoritesScreen({
    required this.favoriteBooks,
    required this.onToggleFavorite,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Books'),
      ),
      body: widget.favoriteBooks.isEmpty
          ? Center(child: Text('No favorite books found.'))
          : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6, // Adjust for item height/width
              ),
              itemCount: widget.favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = widget.favoriteBooks[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BookDetailsScreen(book: book), // Book details screen
                    ));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          book.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        book.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        icon: Icon(
                          book.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: book.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.onToggleFavorite(book); // Toggle favorite
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}