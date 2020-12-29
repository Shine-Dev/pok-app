import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokapp/view/main_view/add_post_view.dart';
import 'get_posts/get_posts_view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _sensitivity = 5;

  void _onItemTapped(int index) {
    setState(() {
      if(mounted) {
        _selectedIndex = index;
      }
    });
  }

  _handleDrag(details) {
    setState(() {
      if (mounted) {
         _selectedIndex = details.delta.dx > 0 ? 0 : 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _handleDrag,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(47, 45, 48, 1),
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png', width: 70, height: 35),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: IndexedStack(
            children: [
              Center(child: GetPostsPage()),
              Center(child: AddPostPage()),
            ],
            index: _selectedIndex,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 32,
          backgroundColor: Colors.deepPurple,
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
      ),
    );
  }
}
