import 'package:redurx/redurx.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('Actions', () {
    test('Action', () {
      final store = Store<State>(State(0));

      expect(store.state.count, equals(0));

      store.dispatch(Increment());

      expect(store.state.count, equals(1));

      store.close();
    });

    test('AsyncAction', () async {
      final store = Store<State>(State(0));

      store.dispatch(AsyncIncrement());

      expect(store.stream, emitsInOrder([State(0), State(1)]));
    });
  });
}
