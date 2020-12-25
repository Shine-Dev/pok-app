import 'dart:async';

import 'package:http/http.dart';
import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/repository/post_repository.dart';

class AddPostBloc implements BlocBase<Post>{
  PostRepository _postRepository;
  StreamController _streamController;

  StreamSink<BlocEvent<Post>> get _sink => _streamController.sink;

  @override
  Stream<BlocEvent<Post>> get stream => _streamController.stream;

  PostBloc() {
    _postRepository = PostRepository();
    _streamController = StreamController<BlocEvent<Post>>();
  }

  addPost(PostContent postContent) async {
    _sink.add(BlocEvent.loading("Adding new Post..."));
    try {
      Post post = await _postRepository.addPost(postContent);
      if(!_streamController.isClosed) {
        _sink.add(BlocEvent.completed(post));
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