abstract class RouteInterceptor {
  const RouteInterceptor();

  /// Intercepts a route request and returns a [RouteInterceptResult].
  /// The interceptor can decide whether to abort, proceed to the next interceptor,
  /// or handle the route entirely.
  ///
  /// The route name and arguments.
  /// Returns a [RouteInterceptResult] which includes the action to take and
  /// potentially a modified route name and arguments.
  Future<RouteInterceptResult> intercept(
    String routeName, {
    Object? arguments,
  });
}

/// Represents the result of a route interception.
///
/// After an interceptor processes a route request, it returns an instance
/// of this class to indicate the action that should be taken next and
/// potentially modify the route settings (name and arguments).
class RouteInterceptResult {
  /// Creates a new [RouteInterceptResult].
  ///
  /// [action] indicates the action that should be taken after the interception,
  /// such as aborting, continuing to the next interceptor, or completing the route handling.
  ///
  /// [name] specifies the name of the route that should be navigated to.
  /// This can be modified by the interceptor to redirect the route.
  ///
  /// [arguments] allows passing additional data to the new route. This is optional.
  const RouteInterceptResult({
    required this.action,
    required this.routeName,
    this.arguments,
  });

  factory RouteInterceptResult.next({
    required String routeName,
    Object? arguments,
  }) =>
      RouteInterceptResult(
        action: RouteInterceptAction.next,
        routeName: routeName,
        arguments: arguments,
      );

  factory RouteInterceptResult.abort({
    required String routeName,
    Object? arguments,
  }) =>
      RouteInterceptResult(
        action: RouteInterceptAction.abort,
        routeName: routeName,
        arguments: arguments,
      );

  factory RouteInterceptResult.complete({
    required String routeName,
    Object? arguments,
  }) =>
      RouteInterceptResult(
        action: RouteInterceptAction.complete,
        routeName: routeName,
        arguments: arguments,
      );

  /// The action to be taken after the interception.
  ///
  /// This determines whether the chain should be stopped, continued to the next interceptor,
  /// or completed with the route push.
  final RouteInterceptAction action;

  /// The name of the route to navigate to.
  ///
  /// Interceptors can modify this value to change the target route.
  final String routeName;

  /// Optional arguments to pass to the new route.
  ///
  /// These arguments can be used to pass additional data to the route.
  final Object? arguments;
}

/// Represents the possible actions a route interceptor can take
/// after being invoked during the route interception process.
enum RouteInterceptAction {
  /// Stops the interception chain and cancels any further actions.
  /// This indicates that the current interceptor has determined
  /// that no route should be pushed, and the navigation process should be aborted.
  abort,

  /// Moves to the next interceptor in the chain.
  /// This indicates that the current interceptor does not want to handle
  /// the route and delegates the decision to subsequent interceptors.
  next,

  /// Completes the interception process and allows the route to be pushed.
  /// This indicates that the current interceptor has handled the route
  /// and the navigation should proceed as expected.
  complete,
}
