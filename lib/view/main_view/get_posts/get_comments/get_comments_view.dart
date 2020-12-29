import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/bloc/comment_bloc/add_comment_bloc.dart';
import 'package:pokapp/bloc/comment_bloc/get_comments_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pokapp/model/comment.dart';

class GetCommentsPage extends StatefulWidget {
  final String postId;

  GetCommentsPage({Key key, this.postId}) : super(key: key);

  @override
  _GetCommentsPage createState() => _GetCommentsPage(postId: postId);
}

class _GetCommentsPage extends State<GetCommentsPage> {
  GetCommentsBloc _getCommentsBloc = GetCommentsBloc();
  AddCommentBloc _addCommentBloc = AddCommentBloc();
  BlocEvent<List<Comment>> _lastGetCommentEvent;
  List<Comment> _comments = List.empty();
  String postId;
  TextEditingController _inputController = new TextEditingController();

  _GetCommentsPage({this.postId}) {
    _getCommentsBloc.getComments(postId);
  }

  _setComments(List<Comment> comments) {
    setState(() {
      this._comments = List.of(comments);
    });
  }

  _eventHandle(BlocEvent<List<Comment>> event) {
    _lastGetCommentEvent = event;
    return _setComments(event.data != null ? event.data : List.empty());
  }

  @override
  void initState() {
    super.initState();
    _getCommentsBloc.stream.listen((BlocEvent<List<Comment>> event) {
      _eventHandle(event);
    });
    _addCommentBloc.stream.listen((BlocEvent<Comment> event) {
      if(event.status == Status.COMPLETED) {
        setState(() {
          _comments.add(event.data);
        });
      }
    });
  }

  _sendComment() {
    if(_inputController.text.trim().length > 0) {
      _addCommentBloc.addComment(CommentContent(
        postId: postId,
        content: _inputController.text,
      ));
      _inputController.clear();
    }
  }

  Widget _comment(Comment comment) {
    return Row(
      children: [Expanded(
        child: Card(
            color: Colors.deepPurple,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ListTile(
                title: Text(DateFormat("dd-M-yyyy HH:mm:ss")
                    .format(comment.createdAt),
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(comment.commentContent.content,
                    style: TextStyle(color: Colors.white70)),
              ),
              ),
            )
        ),
      ]
    );
  }

  Widget _noPostWidget() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
        child: Text("No comments.", style: TextStyle(color: Colors.white),)
    );
  }

  Widget _errorWidget(String message) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
        child: Text(message, style: TextStyle(color: Colors.white),)
    );
  }

  Widget _loadingWidget() {
    return CircularProgressIndicator();
  }

  Widget _statusWidget() {
    if(_lastGetCommentEvent == null) return _loadingWidget();
    switch(_lastGetCommentEvent.status) {
      case Status.COMPLETED:
        return _noPostWidget();
      case Status.LOADING:
        return _loadingWidget();
      case Status.ERROR:
        return _errorWidget(_lastGetCommentEvent.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_comments.length > 0 ? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        shrinkWrap: true,
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          return _comment(_comments[index]);
        },
      ) : _statusWidget(),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 1, color: Colors.deepPurple)),
          child: TextField(
            controller: _inputController,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter a comment...",
              hintStyle:
                  TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
              suffixIcon: IconButton(
                onPressed: _sendComment,
                icon: Icon(Icons.send),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),]
    );
  }
}
