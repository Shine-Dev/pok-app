import 'dart:async';

import 'package:pokapp/bloc/bloc_event.dart';

abstract class BlocBase<T> {
  Stream<BlocEvent<T>> get stream;
  dispose();
}