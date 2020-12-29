import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:pokapp/bloc/bloc_base.dart';
import 'package:pokapp/bloc/bloc_event.dart';
import 'package:pokapp/model/comment.dart';
import 'package:pokapp/model/post.dart';
import 'package:pokapp/network/network_exception.dart';
import 'package:pokapp/repository/comment_repository.dart';
import 'package:pokapp/repository/post_repository.dart';

class GetCommentsBloc extends BlocBase<List<Comment>> {
  CommentRepository _commentRepository = CommentRepository();

  getComments(String postId) async {
    safeEventAdd(BlocEvent.loading("Getting comments..."));
    try {
      List<Comment> comments =
          await _commentRepository.getComments(postId);
      safeEventAdd(BlocEvent.completed(comments));
    }
    catch(e) {
      log(e.message);
      safeEventAdd(BlocEvent.error("Error occured while "
          "contacting the server."));
    }
  }
}