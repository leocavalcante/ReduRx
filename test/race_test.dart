import 'package:redurx/redurx.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  test('Race', () {
    final store = Store<State>(State(0));
    store.dispatch(AsyncIncrement());
    store.dispatch(AsyncIncrement());

    expect(store.stream, emitsInOrder([State(0), State(1), State(2)]));
  });
}
