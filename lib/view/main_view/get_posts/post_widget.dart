import 'package:flutter/material.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/view/main_view/get_posts/get_comments/get_comments_view.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget({Key key, this.post}) : super(key: key);

  @override
  _PostWidget createState() => _PostWidget(post: post);
}

class _PostWidget extends State<PostWidget> {
  final Post post;
  bool _expanded = false;

  _PostWidget({this.post});

  void _onExpansionChange(bool expansion) {
    setState(() {
      this._expanded = expansion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Card(
          color: Color.fromRGBO(133, 92, 209, 1),
          child: ExpansionTile(
            leading: Icon(Icons.location_on, size: 50),
            title: Text(
              post.postContent.title,
              overflow:
                  _expanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(post.postContent.content,
                overflow: _expanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white70)),
            onExpansionChanged: _onExpansionChange,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: Icon(Icons.message,
                          color: Colors.white,
                          size: 20),
                    ),
                    TextSpan(
                      text: " Comments",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ]),
                ),
              ),
              GetCommentsPage(postId: post.id),
            ],
          ),
        ),
      ),
    ]);
  }
}
