import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/api_provider.dart';

class PostRepository {

  final ApiProvider apiProvider = ApiProvider();

  Future<List<Post>> getPosts(PostLocation location) async {
    var response = await apiProvider
        .get("posts?latitude=${location.latitude}"
        "&longitude=${location.longitude}");

    return (response as List).map((e) => Post.fromJson(e)).toList();
  }

  Future<Post> addPost(PostContent postContent) async {
    var response = await apiProvider
        .post("posts",
        {
          "title": postContent.title,
          "content": postContent.content,
          "location": {
            "latitude": postContent.postLocation.latitude,
            "longitude": postContent.postLocation.longitude
          }
        });
    return Post.fromJson(response);
  }

}