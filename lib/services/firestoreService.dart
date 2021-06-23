import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud_with_provider/model/books.dart';

class BookService {
  final firestoreService = FirebaseFirestore.instance;

//create or save book to db
  Future<void> createBooks(Books book) {
    return firestoreService
        .collection('Books')
        .doc(book.id)
        .set(book.bookToMap());
  }

  //update book to db
  Future<void> updateBooks(Books book) {
    return firestoreService
        .collection('Books')
        .doc(book.id)
        .update(book.bookToMap());
  }

  //get all list of books
  Stream<List<Books>> getBooks() {
    return firestoreService.collection('Books').snapshots().map((snapshots) =>
        snapshots.docs
            .map((document) => Books.fromFireStore(document.data()))
            .toList(growable: true));
  }

  Future<void> deleteBook(String id) {
    return firestoreService.collection('Books').doc(id).delete();
  }
}
