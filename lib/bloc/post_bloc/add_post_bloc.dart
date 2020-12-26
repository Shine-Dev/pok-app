import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/bloc/post_bloc/geolocation/geolocation_exception.dart';
import 'package:pokapp/bloc/post_bloc/geolocation/geolocation_provider.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/network_exception.dart';
import 'package:pokapp/repository/post_repository.dart';

class AddPostBloc extends BlocBase<Post> {
  PostRepository _postRepository = PostRepository();
  GeolocationProvider _geolocationProvider = GeolocationProvider();

  addPost(String title, String content) async {
    safeEventAdd(BlocEvent.loading("Adding new Post..."));
    try {
      Post post = await _postRepository.addPost(PostContent(
        title: title,
        content: content,
        postLocation: await _geolocationProvider.determinePosition(),
      ));
      safeEventAdd(BlocEvent.completed(post));
    }
    on GeolocationException catch(e) {
      safeEventAdd(BlocEvent.error(e.message));
    }
    catch(e) {
      log(e.message);
      safeEventAdd(BlocEvent.error("Error occured while "
          "contacting the server."));
    }
  }
}