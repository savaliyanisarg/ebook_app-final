import 'package:flutter/material.dart';
import '../models/book.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void editBook(int index, Book book) {
    _books[index] = book;
    notifyListeners();
  }

  void deleteBook(int index) {
    _books.removeAt(index);
    notifyListeners();
  }
}
