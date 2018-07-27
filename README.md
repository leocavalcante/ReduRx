# ReduRx
👌 A thin layer of a Redux-based state manager on top of RxDart.

> [Flutter bindings](https://github.com/leocavalcante/Flutter-ReduRx)

## Usage

```dart
import 'package:redurx/redurx.dart';

class State {
  State(this.count);
  final int count;
}

class Increment extends Action<State> {
  Increment([this.by = 1]);
  final int by;
  State reduce(State state) => State(state.count + by);
}

void main() {
  final store = Store<State>(State(0));

  print(store.state); // Instance of 'State'
  print(store.state.count); // 0

  store.dispatch(Increment());
  print(store.state.count); // 1

  store.dispatch(Increment(2));
  print(store.state.count); // 3
}
```
