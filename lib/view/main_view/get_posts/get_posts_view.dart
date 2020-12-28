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
  List<Post> posts = List.empty();

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
        height: MediaQuery.of(context).size.height / 1.3,
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

  _postReceived(List<Post> posts) {
    setState(() {
        this.posts = List.of(posts);
    });
  }

  _eventHandle(BlocEvent<List<Post>> event) {
    switch (event.status) {
      case Status.LOADING:
      case Status.ERROR:
        return _postReceived(List.empty());
      default:
        return _postReceived(event.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _getPostsBloc.getPosts(),
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostWidget(post: posts[posts.length - index - 1]);
        },
      ),
    );
  }
}
