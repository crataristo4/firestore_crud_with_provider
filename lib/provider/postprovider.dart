import 'package:firestore_crud_with_provider/model/posts.dart';
import 'package:firestore_crud_with_provider/services/post_service.dart';
import 'package:flutter/foundation.dart';

class PostProvider with ChangeNotifier {
  PostState _postState = PostState.Loading;

  // PostService _postService = PostService.instance;

  PostState get postState => _postState;
  List<Posts> postList = [];

  //FETCH POST -- EITHER THIS
  Future<void> fetchPost() async {
    _postState = PostState.Loading;

    try {
      // final post = await _postService.getPosts();
      final post = await PostService.instance.getPosts();
      _postState = PostState.Loaded;
      postList = post;
      print("?? --- $postList");
    } catch (e) {
      _postState = PostState.Error;
    }

    /*  if(postState == PostState.Error){
      fetchPost();
    }*/

    notifyListeners();
  }

  //FETCH POST -- OR  THAT
  Future<List<Posts>> fetchPostData() async {
    _postState = PostState.Loading;
    try {
      postList = await PostService.instance.getPosts();
      _postState = PostState.Loaded;
    } catch (e) {
      _postState = PostState.Error;
    }

    if (postState == PostState.Error) {
      fetchPostData();
    }
    notifyListeners();
    return postList;
  }

  PostProvider() {
    // fetchPost();
    fetchPostData();
  }
}

//STATES ...
enum PostState { Initial, Loading, Loaded, Error }
