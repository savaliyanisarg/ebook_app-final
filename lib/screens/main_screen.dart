// ignore: depend_on_referenced_packages
import 'favorites_screen.dart';
import 'package:flutter/material.dart';
import 'book_details_screen.dart';
import '../models/book.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'downloads.dart'; // Import the DownloadsScreen
import 'explore_screen.dart'; // Import the ExploreScreen
// ignore: depend_on_referenced_packages
//import 'package:e_book_app/screens/favorites_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Book> books = [
    Book(
        title: 'Calculating stars',
        description: 'Calculating stars',
        category: 'Fiction',
        imagePath: 'Assets/Images/himage1.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',
        isPopular: true), // Mark as popular
    Book(
        title: 'Science',
        description: 'Science',
        category: 'Science',
        imagePath: 'Assets/Images/himage2.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'World History',
        description: 'World History',
        category: 'History',
        imagePath: 'Assets/Images/himage3.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',
        isPopular: true),
    Book(
        title: 'Infinites Powers',
        description: 'Infinites Powers',
        category: 'History',
        imagePath: 'Assets/Images/himage13.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',
        isPopular: true), // Mark as popular
    Book(
        title: 'Harry Potter',
        description: 'Harry Potter',
        category: 'Fantasy',
        imagePath: 'Assets/Images/himage4.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'The uncharted romance',
        description: 'The uncharted romance',
        category: 'Romance',
        imagePath: 'Assets/Images/himage5.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'Emerging Technology',
        description: 'Emerging Technology',
        category: 'Technology',
        imagePath: 'Assets/Images/himage6.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'When The world was over',
        description: 'When The world was over',
        category: 'Fiction',
        imagePath: 'Assets/Images/himage7.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'Allice Network',
        description: 'Allice Network',
        category: 'Fiction',
        imagePath: 'Assets/Images/himage11.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'Infinite Powers',
        description: 'Infinite Powers',
        category: 'Science',
        imagePath: 'Assets/Images/himage8.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'Life in science',
        description: 'Life in science',
        category: 'Science',
        imagePath: 'Assets/Images/himage12.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'History of ancient India',
        description: 'History of ancient India',
        category: 'History',
        imagePath: 'Assets/Images/himage9.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
    Book(
        title: 'King',
        description: 'King',
        category: 'Fantasy',
        imagePath: 'Assets/Images/himage10.jpeg',
        pdfPath: 'Assets/pdf/Week 1.pdf',),
  ];

  List<Book> filteredBooks = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  int _selectedIndex = 0;
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
  }

  void _filterBooks(String query) {
    setState(() {
      filteredBooks = books.where((book) {
        bool matchesCategory = selectedCategory == 'All' ||
            (selectedCategory == 'Popular' && book.isPopular) ||
            book.category == selectedCategory;
        bool matchesQuery =
            book.title.toLowerCase().contains(query.toLowerCase());
        return matchesCategory && matchesQuery;
      }).toList();
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Toggle favorite status
  void _toggleFavorite(Book book) {
    setState(() {
      book.isFavorite = !book.isFavorite;
    });
  }

  // Group books by category
  Map<String, List<Book>> _groupBooksByCategory() {
    Map<String, List<Book>> groupedBooks = {};

    for (var book in filteredBooks) {
      if (groupedBooks.containsKey(book.category)) {
        groupedBooks[book.category]!.add(book);
      } else {
        groupedBooks[book.category] = [book];
      }
    }

    return groupedBooks;
  }

  Widget _buildBookList(String category, List<Book> booksInCategory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            // Get the screen width
            double screenWidth = MediaQuery.of(context).size.width;
            // Determine the number of columns based on the screen width
            int crossAxisCount = (screenWidth ~/ 150).clamp(2, 4);
            // Adjust the child aspect ratio based on the available width
            double childAspectRatio = (screenWidth / crossAxisCount) / 230;

            return GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              shrinkWrap: true, // Use only the space needed
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Responsive number of columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: childAspectRatio, // Responsive aspect ratio
              ),
              itemCount: booksInCategory.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BookDetailsScreen(book: booksInCategory[index]),
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0), // Reduced padding
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            booksInCategory[index].imagePath,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 6), // Adjust spacing
                        Text(
                          booksInCategory[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          booksInCategory[index].description,
                          maxLines: 2, // Adjust number of lines
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Favorite Icon Button
                        IconButton(
                          icon: Icon(
                            booksInCategory[index].isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: booksInCategory[index].isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () =>
                              _toggleFavorite(booksInCategory[index]),
                          padding: EdgeInsets.zero, // Remove default padding
                          constraints: BoxConstraints(), // Remove constraints
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        final groupedBooks = _groupBooksByCategory();

        return ListView.builder(
          itemCount: groupedBooks.keys.length,
          itemBuilder: (context, index) {
            String category = groupedBooks.keys.elementAt(index);
            List<Book> booksInCategory = groupedBooks[category]!;

            return _buildBookList(category, booksInCategory);
          },
        );
      case 1:
        return ExploreScreen(); // Navigate to ExploreScreen
      case 2:
        return DownloadsScreen(); // Navigate to DownloadsScreen
      default:
        return Center(child: Text('Screen not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _filterBooks(value);
                },
              )
            : Text('Books'),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                      filteredBooks = books;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
          IconButton(
            icon: Icon(Icons.person), // Profile icon
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Profile':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  break;
                case 'Favorites':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => FavoritesScreen(
                              onToggleFavorite: (Book) {},
                              favoriteBooks: [],
                            )),
                  );
                  break;
                case 'Settings':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Favorites', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _getSelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
        ],
      ),
    );
  }
}