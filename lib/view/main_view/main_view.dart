import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokapp/view/main_view/add_post_view.dart';
import 'get_posts/get_posts_view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  _moveToPage(int index) {
    setState(() {
      if(mounted) {
        _selectedIndex = index;
        _pageController.animateToPage(
          _selectedIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  _onPageChanged(int index) {
    primaryFocus.unfocus();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 45, 48, 1),
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', width: 70, height: 35),
      ),
      body: PageView(
        onPageChanged: _onPageChanged,
        children: [
          Center(child: GetPostsPage()),
          Center(child: AddPostPage()),
        ],
        controller: _pageController,
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
        onTap: _moveToPage,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
