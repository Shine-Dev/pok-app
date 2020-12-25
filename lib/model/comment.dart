class CommentContent {
  final String postId;
  final String content;

  CommentContent({this.postId, this.content});
}


class Comment {
  final String id;
  final CommentContent commentContent;
  final DateTime createdAt;

  Comment({this.id,
    this.commentContent,
    this.createdAt});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"],
      commentContent: CommentContent(
        postId: json["postId"],
        content: json["content"]
      ),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}