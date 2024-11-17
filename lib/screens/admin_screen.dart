import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import 'package:ebook_app/providers/book_provider.dart';

class AdminScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _pdfPathController = TextEditingController();

  void _clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    _imagePathController.clear();
    _pdfPathController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add New Book'),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(labelText: 'Title'),
                          ),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(labelText: 'Description'),
                          ),
                          TextField(
                            controller: _categoryController,
                            decoration: InputDecoration(labelText: 'Category'),
                          ),
                          TextField(
                            controller: _imagePathController,
                            decoration: InputDecoration(labelText: 'Image Path'),
                          ),
                          TextField(
                            controller: _pdfPathController,
                            decoration: InputDecoration(labelText: 'PDF Path'),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          bookProvider.addBook(
                            Book(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              category: _categoryController.text,
                              imagePath: _imagePathController.text,
                              pdfPath: _pdfPathController.text,
                            ),
                          );
                          _clearFields();
                          Navigator.pop(context);
                        },
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          return bookProvider.books.isEmpty
              ? Center(child: Text('No books available.'))
              : ListView.builder(
                  itemCount: bookProvider.books.length,
                  itemBuilder: (context, index) {
                    final book = bookProvider.books[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.description),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
