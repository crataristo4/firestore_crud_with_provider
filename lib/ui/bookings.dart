import 'package:firestore_crud_with_provider/model/books.dart';
import 'package:firestore_crud_with_provider/ui/edit_bookings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookList = Provider.of<List<Books>>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("All books"),
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EditBookings())),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          return ListView.builder(
            itemCount: bookList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: ListTile(
                  title: Text(bookList[index].title),
                  trailing: Text(bookList[index].desc),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditBookings(
                              books: bookList[index],
                            )));
                  },
                ),
              );
            },
          );
        }));
  }
}
