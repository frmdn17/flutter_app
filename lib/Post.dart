import 'dart:convert';
import 'ApiService.dart';


class Post {
  int id;
  String title;
  String body;
  int userId;

  Post({this.id = 0, this.body, this.title, this.userId});

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
        id: map["id"], title: map["title"], body: map["body"], userId: map["userId"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body, "userId": userId};
  }

  @override
  String toString() {
    return 'Profile{id: $id, title: $title, body: $body, userId: $userId}';
  }

}

List<Post> postFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Post>.from(data.map((item) => Post.fromJson(item)));
}

String postToJson(Post data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}