import 'dart:async';

import 'package:http/http.dart';
import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/model/comment.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/repository/comment_repository.dart';
import 'package:pokapp/repository/post_repository.dart';

class GetCommentsBloc implements BlocBase<List<Comment>>{
  CommentRepository _commentRepository;
  StreamController _streamController;

  StreamSink<BlocEvent<List<Comment>>> get _sink => _streamController.sink;

  @override
  Stream<BlocEvent<List<Comment>>> get stream => _streamController.stream;

  PostBloc() {
    _commentRepository = CommentRepository();
    _streamController = StreamController<BlocEvent<List<Comment>>>();
  }

  addPost(String postId) async {
    _sink.add(BlocEvent.loading("Getting comments..."));
    try {
      List<Comment> comments =
          await _commentRepository.getComments(postId);

      if(!_streamController.isClosed) {
        _sink.add(BlocEvent.completed(comments));
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