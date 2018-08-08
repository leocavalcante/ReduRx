import 'dart:async';

import 'package:redurx/redurx.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('Store', () {
    test('Store', () {
      final store = Store<State>();

      expect(store, TypeMatcher<Store<State>>());

      store.close();
    });

    test('.stream', () {
      final store = Store<State>();

      expect(store.stream, TypeMatcher<Stream<State>>());

      store.close();
    });

    test('.stream.state', () {
      final store = Store<State>();

      expect(store.state, isNull);

      store.close();
    });

    test('initialState', () {
      final store = Store<State>(State(0));

      expect(store.state, TypeMatcher<State>());
      expect(store.state.count, equals(0));

      store.close();
    });
  });
}
