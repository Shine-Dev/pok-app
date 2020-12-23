import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;

  /*void _signIn() {
    setState(() {
      googleSignIn().then((value) => print);
    });
  }*/

  void _signIn() {

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 45, 48, 1),
      appBar: AppBar(
        // Here we take the value from the MainPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset('assets/images/logo.png',width: 70, height: 35),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.deepPurpleAccent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.note, size: 50),
                    title: Text('Heart Shaker',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('TWICE',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.deepPurpleAccent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.note, size: 50),
                    title: Text('Heart Shaker',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('TWICE',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.deepPurpleAccent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.note, size: 50),
                    title: Text('Heart Shaker',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('TWICTWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICETWICEE',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.deepPurpleAccent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.note, size: 50),
                    title: Text('Heart Shaker',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('TWICE',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
