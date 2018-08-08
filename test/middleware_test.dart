import 'package:redurx/redurx.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('Middleware', () {
    test('beforeAction', () {
      final store = Store<State>(State(0));
      store.add(BeforeActionMiddleware());

      expect(store.state.count, equals(0));

      store.dispatch(Increment());

      expect(store.state.count, equals(3));
    });

    test('async:beforeAction', () {
      final store = Store<State>(State(0));
      store.add(BeforeActionMiddleware());
      store.dispatch(AsyncIncrement());

      expect(store.stream, emitsInOrder([State(0), State(3)]));
    });

    test('afterAction', () {
      final store = Store<State>(State(0));
      store.add(AfterActionMiddleware());

      expect(store.state.count, equals(0));

      store.dispatch(Increment());

      expect(store.state.count, equals(-1));
    });

    test('async:afterAction', () {
      final store = Store<State>(State(0));
      store.add(AfterActionMiddleware());
      store.dispatch(AsyncIncrement());

      expect(store.stream, emitsInOrder([State(0), State(-1)]));
    });

    test('before&afterAction', () {
      final store = Store<State>(State(0));
      store.add(BeforeActionMiddleware());
      store.add(AfterActionMiddleware());

      expect(store.state.count, equals(0));

      store.dispatch(Increment());

      expect(store.state.count, equals(1));
    });
  });
}
