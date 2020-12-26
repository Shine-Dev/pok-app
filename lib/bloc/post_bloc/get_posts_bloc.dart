import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/bloc/post_bloc/geolocation/geolocation_exception.dart';
import 'package:pokapp/bloc/post_bloc/geolocation/geolocation_provider.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/network_exception.dart';
import 'package:pokapp/repository/post_repository.dart';

class GetPostsBloc extends BlocBase<List<Post>> {
  PostRepository _postRepository = PostRepository();
  GeolocationProvider _geolocationProvider = GeolocationProvider();

  getPosts() async {
    safeEventAdd(BlocEvent.loading("Getting posts..."));
    try {
      Position location = await _geolocationProvider.determinePosition();
      List<Post> posts = await _postRepository.getPosts(location);
      safeEventAdd(BlocEvent.completed(posts));
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