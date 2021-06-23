import 'package:firestore_crud_with_provider/model/books.dart';
import 'package:firestore_crud_with_provider/provider/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookings extends StatefulWidget {
  final Books? books;

  EditBookings({this.books, Key? key}) : super(key: key);

  @override
  _EditBookingsState createState() => _EditBookingsState();
}

class _EditBookingsState extends State<EditBookings> {
  final formKey = GlobalKey<FormState>();
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDesc = TextEditingController();
  String? updateButton;

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add items"),
        backgroundColor: Colors.indigo,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: txtTitle,
              validator: (value) =>
                  value!.length > 5 ? null : 'please enter a title',
              onChanged: (value) => bookProvider.changeTitle(value),
              decoration: InputDecoration(labelText: "Enter Book title"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: txtDesc,
              validator: (value) =>
                  value!.length > 5 ? null : 'please enter a description',
              onChanged: (value) => bookProvider.changeDesc(value),
              decoration: InputDecoration(labelText: "Enter Book description"),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.books != null) {
                    //update book record
                    bookProvider.updateBook();
                  } else {
                    //create new book
                    bookProvider.saveBookToDb();
                  }

                  Navigator.pop(context, true);
                  // txtDesc.dispose();
                  //txtDesc.dispose();
                  //formKey.currentState!.dispose();
                }
              },
              child: Text(updateButton!),
              color: Colors.indigo,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            widget.books != null
                ? MaterialButton(
                    onPressed: () {
                      bookProvider.deleteBook(widget.books!.id);
                      Navigator.pop(context, true);
                    },
                    child: Text("Delete"),
                    color: Colors.red,
                    textColor: Colors.white,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    txtDesc.dispose();
    txtTitle.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.books != null) {
      txtTitle.text = widget.books!.title;
      txtDesc.text = widget.books!.desc;
      setState(() {
        updateButton = "Update";
      });

      Future.delayed(Duration.zero, () {
        final bookProvider = Provider.of<BookProvider>(context, listen: false);
        bookProvider.loadBookData(widget.books);
      });
    } else {
      txtTitle.text = "";
      txtDesc.text = "";
      Future.delayed(Duration.zero, () {
        final bookProvider = Provider.of<BookProvider>(context, listen: false);
        bookProvider.loadBookData(Books());
      });
      setState(() {
        updateButton = "Save";
      });
    }
    super.initState();
  }
}
