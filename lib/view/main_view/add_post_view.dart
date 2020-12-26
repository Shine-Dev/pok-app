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
  final _formKey = GlobalKey<FormState>();
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

  _showSnackBar(SnackBar snackbar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _success() {
    setState(() {
      _buttonDisabled = false;
      _titleController.text = "";
      _contentController.text = "";
    });
    _showSnackBar(SnackBar(
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
      _titleController.text = "";
      _contentController.text = "";
    });
    _showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
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

  String _textfieldValidate(value) {
    if (value.isEmpty) {
      return '';
    }
    return null;
  }

  _submit() {
    // Validate returns true if the form is valid, otherwise false.
    if (_formKey.currentState.validate()) {
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
              height: MediaQuery.of(context).size.height * 0.53,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                color: Colors.deepPurpleAccent,
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
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
                          validator: _textfieldValidate,
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 80)),
                            hintText: "Content",
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontStyle: FontStyle.italic),
                          ),
                          maxLines: 7,
                          minLines: 7,
                          validator: _textfieldValidate,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
