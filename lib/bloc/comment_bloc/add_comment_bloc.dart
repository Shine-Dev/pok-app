import 'dart:async';

import 'package:http/http.dart';
import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/model/comment.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/repository/comment_repository.dart';
import 'package:pokapp/repository/post_repository.dart';

class AddCommentBloc implements BlocBase<Comment>{
  CommentRepository _commentRepository;
  StreamController _streamController;

  StreamSink<BlocEvent<Comment>> get _sink => _streamController.sink;

  @override
  Stream<BlocEvent<Comment>> get stream => _streamController.stream;

  PostBloc() {
    _commentRepository = CommentRepository();
    _streamController = StreamController<BlocEvent<Comment>>();
  }

  addPost(CommentContent commentContent) async {
    _sink.add(BlocEvent.loading("Adding new Comment..."));
    try {
      Comment comment = await _commentRepository.addComment(commentContent);
      if(!_streamController.isClosed) {
        _sink.add(BlocEvent.completed(comment));
      }
    } catch(e) {
      if(!_streamController.isClosed) {
        _sink.add(BlocEvent.error(e.toString()));
      }
    }
  }

  @override
  dispose() {
    _streamController.close();
  }
}