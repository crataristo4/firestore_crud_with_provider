import 'dart:convert';

import 'package:firestore_crud_with_provider/model/Users.dart';
import 'package:firestore_crud_with_provider/services/github_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  Users? _users;
  String? errorMessage;
  bool isLoading = false;

  Future<bool> fetchUser(userName) async {
    setLoading(true);

    await GithubService(userName: userName).fetchUser().then((value) {
      setLoading(false);
      //check response
      if (value.statusCode == 200) {
        /// ok
        print("Data ${value.body}");

        setUser(Users.fromJson(json.decode(value.body)));
      } else {
        Map<String, dynamic> result = json.decode(value.body);
        setErrorMessage(result['message']);
      }
    });

    return isUser();
  }

  bool isUser() {
    return _users != null ? true : false;
  }

  //loading
  void setLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  bool loading() {
    return isLoading;
  }

  Users getUsers() {
    return _users!;
  }

  String getErrorMessage() {
    return errorMessage!;
  }

  //error message
  void setErrorMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  //set user
  void setUser(value) {
    _users = value;
    notifyListeners();
  }
}
