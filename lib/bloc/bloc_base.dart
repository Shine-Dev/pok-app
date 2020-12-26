import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pokapp/bloc/bloc_event.dart';

abstract class BlocBase<T> {
  StreamController _streamController = new StreamController<BlocEvent<T>>();
  Stream<BlocEvent<T>> get stream => _streamController.stream;
  StreamSink<BlocEvent<T>> get _sink => _streamController.sink;

  @protected
  safeEventAdd(BlocEvent<T> event) {
    if(!_streamController.isClosed) {
      _sink.add(event);
    }
  }

  dispose() {
    _streamController.close();
  }
}