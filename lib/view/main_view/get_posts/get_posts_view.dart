import 'package:flutter/material.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/bloc/post_bloc/get_posts_bloc.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/view/main_view/get_posts/post_widget.dart';

class GetPostsPage extends StatefulWidget {

  GetPostsPage({Key key}) : super(key: key);

  @override
  _GetPostsPage createState() => _GetPostsPage();
}

class _GetPostsPage extends State<GetPostsPage> {
  GetPostsBloc _getPostsBloc = GetPostsBloc();
  List<Post> _posts = List.empty();
  BlocEvent<List<Post>> _lastEvent;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _getPostsBloc.stream.listen((BlocEvent<List<Post>> event) {
      _eventHandle(event);
    });
    super.initState();
  }

  Widget _listCenterText(String text) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.2,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.deepPurple,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
    );
  }

  _setPosts(List<Post> posts) {
    setState(() {
        this._posts = List.of(posts);
    });
  }

  _eventHandle(BlocEvent<List<Post>> event) {
    _lastEvent = event;
    return _setPosts(event.data != null
      ? event.data
      : List.empty()
    );
  }

  String _getMessage() {
    if(_lastEvent == null)
      return "Pull down to search posts in the area";
    else if(_lastEvent.status == Status.COMPLETED)
      return "No posts in the area.";
    else
      return _lastEvent.message;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _getPostsBloc.getPosts(),
      child: _posts.length > 0 ? ListView.builder(
        padding: EdgeInsets.fromLTRB(2, 8, 2, 8),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return PostWidget(post: _posts[_posts.length - index - 1]);
        },
      ) : ListView(
        children: [ _listCenterText(_getMessage()), ]
      ),
    );
  }
}
