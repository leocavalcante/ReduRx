import 'dart:async';

import 'package:redurx/redurx.dart';

class State {
  State(this.count);
  final int count;

  @override
  bool operator ==(other) => count == other.count;
}

class Increment extends Action<State> {
  @override
  State reduce(State state) => State(state.count + 1);
}

class AsyncIncrement extends AsyncAction<State> {
  @override
  Future<State> reduce(State state) async => State(state.count + 1);
}

class BeforeActionMiddleware extends Middleware<State> {
  @override
  State beforeAction(ActionType action, State state) {
    return State(state.count + 2);
  }
}

class AfterActionMiddleware extends Middleware<State> {
  @override
  State afterAction(ActionType action, State state) {
    return State(state.count - 2);
  }
}
