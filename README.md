# ReduRx [![Build Status](https://travis-ci.org/leocavalcante/ReduRx.svg?branch=master)](https://travis-ci.org/leocavalcante/ReduRx)
👌 A thin layer of a Redux-based state manager on top of RxDart.

[Flutter bindings](https://github.com/leocavalcante/Flutter-ReduRx) &bull; [React bindings](https://github.com/leocavalcante/React-ReduRx)

## Usage

```dart
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
