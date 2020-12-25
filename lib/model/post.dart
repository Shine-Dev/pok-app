class PostLocation {
  final double latitude;
  final double longitude;

  PostLocation({
    this.latitude,
    this.longitude
  });
}

class PostContent {
  final String title;
  final String content;
  final PostLocation postLocation;

  PostContent({
    this.title,
    this.content,
    this.postLocation,
  });
}

class Post extends PostContent{
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
        postLocation: PostLocation(
          latitude: json["latitude"],
          longitude: json["longitude"],
        ),
      ),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}