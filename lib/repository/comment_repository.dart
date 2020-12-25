import 'package:pokapp/model/comment.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/api_provider.dart';

class CommentRepository {

  final ApiProvider apiProvider = ApiProvider();

  Future<List<Comment>> getComments(String postId) async {
    var response = await apiProvider
        .get("posts/$postId/comments");
    return (response as List).map((e) => Comment.fromJson(e)).toList();
  }

  Future<Comment> addComment(CommentContent commentContent) async {
    var response = await apiProvider
        .post("posts/${commentContent.postId}/comments",
        {
          "content": commentContent.content,
        });
    return Comment.fromJson(response);
  }

}