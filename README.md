# ReduRx [![Build Status](https://travis-ci.org/leocavalcante/ReduRx.svg?branch=master)](https://travis-ci.org/leocavalcante/ReduRx)
👌 A thin layer of a Redux-based state manager on top of RxDart.

[Flutter bindings](https://github.com/leocavalcante/Flutter-ReduRx) &bull; [React bindings](https://github.com/leocavalcante/React-ReduRx)

## Getting started
* [Tutorial: Handling State in Flutter with ReduRx](https://medium.com/@leocavalcante/tutorial-handling-state-in-flutter-with-redurx-b4d50c647e4a)

## Usage

```dart
import 'dart:async';
import 'package:redurx/redurx.dart';

class State {
  State(this.count);
  final int count;

  @override
  String toString() => count.toString();
}

class Increment extends Action<State> {
  Increment([this.by = 1]);
  final int by;
  State reduce(State state) => State(state.count + by);
}

class AsyncIncrement extends AsyncAction<State> {
  @override
  Future<Computation<State>> reduce(State state) async {
    int result = await doAsyncTask();
    return (State state) =>
      State(count: state.count + result);
    }
  }
}

void main() {
  final store = Store<State>(State(0));

  store.add(LogMiddleware<State>());
  print(store.state.count); // 0

  store.dispatch(Increment());
  // Before action: Increment: 0 (from LogMiddleware)
  // After action: Increment: 1 (from LogMiddleware)
  print(store.state.count); // 1

  store.dispatch(Increment(2));
  // Before action: Increment: 1 (from LogMiddleware)
  // After action: Increment: 3 (from LogMiddleware)
  print(store.state.count); // 3
}
```

---

Just give it a try. Feel free to open Issues and PRs!
