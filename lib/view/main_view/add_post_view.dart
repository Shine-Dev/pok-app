import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/bloc/post_bloc/add_post_bloc.dart';
import 'package:pokapp/model/post.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key key}) : super(key: key);

  @override
  _AddPostPage createState() => _AddPostPage();
}

class _AddPostPage extends State<AddPostPage> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  bool _buttonDisabled = false;

  final AddPostBloc addPostBloc = AddPostBloc();

  @override
  void initState() {
    addPostBloc.stream.listen((BlocEvent<Post> event) {
      switch (event.status) {
        case Status.LOADING:
          _loading(event.message);
          break;

        case Status.ERROR:
          _error(event.message);
          break;

        case Status.COMPLETED:
          _success();
          break;
      }
    });
    super.initState();
  }

  _showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _success() {
    setState(() {
      _buttonDisabled = false;
      _titleController.text = "";
      _contentController.text = "";
    });
    _showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.greenAccent,
      content: Row(children: [
        Icon(Icons.done),
        Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Text(
              "Post Created",
              style: TextStyle(color: Colors.white),
            ))
      ]),
    ));
  }

  _loading(String message) {
    _showSnackBar(SnackBar(
      duration: Duration(days: 365),
      backgroundColor: Colors.orangeAccent,
      content: Row(children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ))
      ]),
    ));
  }

  _error(String message) {
    setState(() {
      _buttonDisabled = false;
    });
    _showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 1),
      content: Row(children: [
        Icon(Icons.error),
        Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ))
      ]),
    ));
  }

  bool _textValidate(String value) {
    return value.trim().isNotEmpty;
  }

  bool _formValidate() {
    return _textValidate(_titleController.text)
        && _textValidate(_contentController.text);
  }

  _submit() {
    if (_formValidate()) {
      setState(() {
        _buttonDisabled = true;
      });
      addPostBloc.addPost(_titleController.text, _contentController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              WidgetSpan(
                child: Icon(Icons.note_add, color: Colors.white, size: 30),
              ),
              TextSpan(
                text: "Add Post",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ]),
          ),
          Center(
            child: Container(
              height: 355,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                color: Color.fromRGBO(133, 92, 209, 1),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        controller: _titleController,
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 80)),
                          hintText: "Title",
                          hintStyle: TextStyle(
                              color: Colors.white54,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        controller: _contentController,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 7,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 80)),
                          hintText: "Content",
                          hintStyle: TextStyle(
                              color: Colors.white54,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                        onPressed: _buttonDisabled ? null : _submit,
                        child: Text('Create Post'),
                      ),
                    ),
                  )
                  // Add TextFormFields and ElevatedButton here.
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
