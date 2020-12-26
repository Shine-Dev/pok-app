import 'package:geolocator/geolocator.dart';

class PostContent {
  final String title;
  final String content;
  final Position postLocation;

  PostContent({
    this.title,
    this.content,
    this.postLocation,
  });
}

class Post {
  final String id;
  final DateTime createdAt;
  final PostContent postContent;

  Post({this.id, this.postContent, this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      postContent: PostContent(
        title: json["title"],
        content: json["content"],
        postLocation: Position(
          latitude: json["latitude"],
          longitude: json["longitude"],
        ),
      ),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}