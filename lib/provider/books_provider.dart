import 'package:firestore_crud_with_provider/model/books.dart';
import 'package:firestore_crud_with_provider/services/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BookProvider with ChangeNotifier {
  String? _id, _title, _desc;
  BookService bookService = BookService();
  var _uuid = Uuid();

  get title => _title;

  changeTitle(value) {
    _title = value;
    notifyListeners();
  }

  get desc => _desc;

  changeDesc(value) {
    _desc = value;
    notifyListeners();
  }

  loadBookData(Books? books) {
    _title = books!.title;
    _desc = books.desc;
    _id = books.id;
  }

  saveBookToDb() {
    print("$title , $_desc");
    _id = _uuid.v4();
    Books newBooks = Books(id: _id, title: title, desc: desc);
    bookService.createBooks(newBooks);
  }

  updateBook() {
    Books updateBook = Books(id: _id, title: title, desc: desc);
    bookService.updateBooks(updateBook);
    print("$title , $_desc");
  }

  deleteBook(String id) {
    bookService.deleteBook(id);
  }
}
