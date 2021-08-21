import 'package:http/http.dart' as http;

class GithubService {
  final userName;
  final apiUrl = 'https://api.github.com/';
  static final clientId = 'bf09c32da2d695f96024';
  static final tokenId = '0131b2b147de2ab7fc2c0f890e8b6d7f3069f02a';
  final query = "?client_id=$clientId&client_secret=$tokenId";
  final userEndPoint = 'users/';
  final followingEndPoint = '/following';

  GithubService({required this.userName});

  Future<http.Response> fetchUser() {
    return http.get(Uri.parse("$apiUrl$userEndPoint$userName$query"));
  }

  Future<http.Response> fetchFollowing() {
    return http.get(
        Uri.parse("$apiUrl$userEndPoint$userName$followingEndPoint$query"));
  }
}
