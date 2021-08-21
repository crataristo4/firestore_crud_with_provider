import 'package:firestore_crud_with_provider/provider/postprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final postList = Provider.of<PostProvider>(context);

    final postsList = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Builder(builder: (context) {
        final posts = postsList.postList;
        if (postsList.postState == PostState.Loading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (postsList.postState == PostState.Error)
          return Center(
            child: Text("Error occurred"),
          );
        return Container(
          margin: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: posts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text(posts[index].title),
                  subtitle: Text(posts[index].body),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
