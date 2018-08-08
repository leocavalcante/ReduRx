library redurx;

import 'dart:async';

import 'package:rxdart/rxdart.dart';

export 'src/log_middleware.dart';

abstract class ActionType {}

abstract class Action<T> implements ActionType {
  T reduce(T state);
}

abstract class AsyncAction<T> implements ActionType {
  Future<T> reduce(T state);
}

abstract class Middleware<T> {
  T beforeAction(ActionType action, T state) => state;
  T afterAction(ActionType action, T state) => state;
}

class Store<T> {
  Store([T initialState])
      : subject = BehaviorSubject<T>(seedValue: initialState);

  final BehaviorSubject<T> subject;
  final List<Middleware<T>> middlewares = [];

  Stream<T> get stream => subject.stream;
  T get state => subject.value;
  Stream<S> map<S>(S convert(T state)) => stream.map(convert);

  Store<T> dispatch(ActionType action) {
    final beforeMiddlewares = middlewares.fold<T>(
        state, (state, middleware) => middleware.beforeAction(action, state));

    if (action is Action<T>) {
      final afterAction = action.reduce(beforeMiddlewares);
      final afterMiddlewares = _foldAfterActionMiddlewares(afterAction, action);
      subject.add(afterMiddlewares);
    }

    if (action is AsyncAction<T>) {
      action.reduce(beforeMiddlewares).then((afterAction) {
        final afterMiddlewares =
            _foldAfterActionMiddlewares(afterAction, action);
        subject.add(afterMiddlewares);
      });
    }

    return this;
  }

  Store<T> add(Middleware<T> middleware) {
    middlewares.add(middleware);
    return this;
  }

  void close() => subject.close();

  T _foldAfterActionMiddlewares(T initialValue, ActionType action) =>
      middlewares.fold<T>(initialValue,
          (state, middleware) => middleware.afterAction(action, state));
}
