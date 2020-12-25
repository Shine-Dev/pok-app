import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokapp/model/comment.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/network_exception.dart';
import 'package:pokapp/repository/comment_repository.dart';
import 'package:pokapp/repository/post_repository.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions;

  _MainPageState() {
    _widgetOptions = <Widget>[
      RaisedButton(
        child: Text('Test'),
        onPressed: _test,
      ),
      Card(
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(),
          ],
        ),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _test() async {
    print("ok");
    try {
      PostRepository postRepository = PostRepository();

      List<Post> posts1 = await postRepository
          .getPosts(PostLocation(latitude: 12, longitude: 12));
      CommentRepository commentRepository = CommentRepository();
      PostContent postContent = PostContent(
        title: "test",
        content: "test2",
        postLocation: PostLocation(
          latitude: 12,
          longitude: 11.9999999,
        ),
      );

      Post post = await postRepository.addPost(postContent);
      print(post.postContent.title);
      List<Post> posts = await postRepository
          .getPosts(PostLocation(latitude: 12, longitude: 12));
      posts.forEach((element) {
        //print(element.id);
      });
      Comment c = await commentRepository
          .addComment(CommentContent(postId: post.id, content: "cool"));
      print(c.id);

      List<Comment> comments = await commentRepository.getComments(c.id);
      comments.forEach((element) {
        print(element.commentContent.postId);
      });
    } on FetchException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 45, 48, 1),
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', width: 70, height: 35),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurpleAccent,
        selectedItemColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Write post',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
