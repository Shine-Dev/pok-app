import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokapp/model/comment.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/network_exception.dart';
import 'package:pokapp/repository/comment_repository.dart';
import 'package:pokapp/repository/post_repository.dart';
import 'package:pokapp/view/main_view/add_post_view.dart';

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
      ),
      AddPostPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      if(mounted) {
        _selectedIndex = index;
      }
    });
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
