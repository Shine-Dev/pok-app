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

class AddCommentBloc extends BlocBase<Comment> {
  CommentRepository _commentRepository = CommentRepository();

  addPost(CommentContent commentContent) async {
    safeEventAdd(BlocEvent.loading("Adding new Comment..."));
    try {
      Comment comment = await _commentRepository.addComment(commentContent);
      safeEventAdd(BlocEvent.completed(comment));
    }
    catch(e) {
      log(e.message);
      safeEventAdd(BlocEvent.error("Error occured while "
          "contacting the server."));
    }
  }
}