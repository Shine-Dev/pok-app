import 'dart:async';

import 'package:http/http.dart';
import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/repository/post_repository.dart';

class PostBloc implements BlocBase<List<Post>>{
  PostRepository _postRepository;
  StreamController _streamController;

  StreamSink<BlocEvent<List<Post>>> get _sink => _streamController.sink;

  @override
  Stream<BlocEvent<List<Post>>> get stream => _streamController.stream;

  PostBloc() {
    _postRepository = PostRepository();
    _streamController = StreamController<BlocEvent<List<Post>>>();
  }

  getPosts(PostLocation location) async {
    _sink.add(BlocEvent.loading("Getting posts..."));
    try {
      List<Post> posts = await _postRepository.getPosts(location);
      if(!_streamController.isClosed) {
        _sink.add(BlocEvent.completed(posts));
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