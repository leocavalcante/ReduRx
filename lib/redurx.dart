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
  Store([T initialState])
      : subject = BehaviorSubject<T>(seedValue: initialState);

  final BehaviorSubject<T> subject;

  Stream<T> get stream => subject.stream;
  T get state => subject.value;
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

  void close() => subject.close();
}
