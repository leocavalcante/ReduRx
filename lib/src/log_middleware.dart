import '../redurx.dart';

/// Middleware that prints when action's reducers are applied.
class LogMiddleware<T> extends Middleware<T> {
  /// Prints before the Action reducer call.
  @override
  T beforeAction(action, state) {
    print('Before action: ${action.runtimeType}: $state');
    return super.beforeAction(action, state);
  }

  /// Prints after the Action reducer call.
  @override
  T afterAction(action, state) {
    print('After action: ${action.runtimeType}: $state');
    return super.afterAction(action, state);
  }
}
