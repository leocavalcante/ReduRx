import '../redurx.dart';

/// Middleware that prints when action's reducers are applied.
class LogMiddleware<T> extends Middleware<T> {
  /// Prints before the Action reducer call.
  @override
  T beforeAction(store, action, state) {
    print('Before action: ${action.runtimeType}: $state');
    return super.beforeAction(store, action, state);
  }

  /// Prints after the Action reducer call.
  @override
  T afterAction(store, action, state) {
    print('After action: ${action.runtimeType}: $state');
    return super.afterAction(store, action, state);
  }
}
