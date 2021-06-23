import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_crud_with_provider/model/books.dart';
import 'package:firestore_crud_with_provider/provider/books_provider.dart';
import 'package:firestore_crud_with_provider/services/firestoreService.dart';
import 'package:firestore_crud_with_provider/ui/bookings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final firestore = BookService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        StreamProvider<List<Books>>.value(
            value: firestore.getBooks(), initialData: []),
      ],
      child: MaterialApp(
        title: 'Firestore provider',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Bookings(),
      ),
    );
  }
}
