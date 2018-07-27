import 'dart:async';

import 'package:redurx/redurx.dart';
import 'package:test/test.dart';

class State {}

void main() {
  group('Store', () {
    final store = Store<State>();

    test('Store', () {
      expect(store, TypeMatcher<Store<State>>());
    });

    test('.stream', () {
      expect(store.stream, TypeMatcher<Stream<State>>());
    });

    test('.stream.state', () {
      expect(store.state, isNull);
    });

    store.close();
  });
}
