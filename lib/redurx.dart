library redurx;

import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class ActionType {}

abstract class Action<T> implements ActionType {
  T reduce(T state);
}

abstract class AsyncAction<T> implements ActionType {
  Future<T> reduce(T state);
}

class Store<T> {
  final subject = BehaviorSubject<T>();

  Stream<T> get stream => subject.stream;
  Stream<S> map<S>(S convert(T state)) => stream.map(convert);

  Store<T> dispatch(ActionType action) {
    if (action is Action<T>) {
      subject.add(action.reduce(subject.value));
    }

    if (action is AsyncAction<T>) {
      action.reduce(subject.value).then(subject.add);
    }

    return this;
  }
}
