import 'package:firestore_crud_with_provider/model/posts.dart';
import 'package:http/http.dart' as http;

class PostService {
  static PostService? _instance;
  final url = "https://jsonplaceholder.typicode.com/posts";

  PostService._();

  static PostService get instance {
    return _instance == null ? _instance = PostService._() : _instance!;
  }

  Future<List<Posts>> getPosts() async {
    final getPost = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      "accept": 'application/json'
    });

    final postList = postsFromJson(getPost.body);

    return postList;
  }
}
