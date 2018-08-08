import '../redurx.dart';

class LogMiddleware<T> extends Middleware<T> {
  @override
  T beforeAction(action, state) {
    print('Before action: ${action.runtimeType}: $state');
    return super.beforeAction(action, state);
  }

  @override
  T afterAction(action, state) {
    print('After action: ${action.runtimeType}: $state');
    return super.afterAction(action, state);
  }
}
