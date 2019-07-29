import 'package:flutter_app/Post.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  Client client = Client();

  Future<List<Post>> getPosts() async {
    final response = await client.get("$baseUrl/posts");
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> addPosts(Post data) async {
    final response = await client.post("$baseUrl/posts",
      headers: {"content-type": "application/json"},
      body: postToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updPosts(Post data) async {
    final response = await client.put("$baseUrl/posts/${data.id}",
      headers: {"content-type": "application/json"},
      body: postToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delPosts(int id) async {
    final response = await client.delete("$baseUrl/posts/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}