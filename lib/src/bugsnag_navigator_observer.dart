import 'package:flutter/widgets.dart';

import 'bugsnag_navigator_observer_callbacks.dart';

class BugsnagNavigatorObserver extends NavigatorObserver {
  final bool leaveBreadcrumbs;
  final bool setContext;
  final String? navigatorName;

  /// Create and configure a `BugsnagNavigatorObserver` to listen for navigation
  /// events and leave breadcrumbs and/or set the context.
  ///
  /// If the [navigatorName] is `null` then the breadcrumbs will be suffixed
  /// with `"navigator"` resulting in breadcrumbs such as `Route pushed on navigator`,
  /// `Route replaced on navigator` and `Route removed from navigator`.
  ///
  /// Typically you will configure this in you `MaterialApp`, `CupertinoApp`
  /// or `Navigator`:
  /// ```dart
  /// return MaterialApp(
  ///   navigatorObservers: [BugsnagNavigatorObserver()],
  ///   initialRoute: '/',
  ///   routes: {
  ///     '/': (context) => const AppHomeWidget(),
  /// ```
  BugsnagNavigatorObserver({
    this.leaveBreadcrumbs = true,
    this.setContext = true,
    this.navigatorName,
  });

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _leaveBreadcrumb('Route replaced on', {
      if (oldRoute != null) 'oldRoute': _routeMetadata(oldRoute),
      if (newRoute != null) 'newRoute': _routeMetadata(newRoute),
    });

    _updateContext(newRoute);
    callbacks.didReplaceRoute(
      newRoute: newRoute,
      previousRoute: oldRoute,
      navigatorName: navigatorName,
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _leaveBreadcrumb('Route removed from', {
      'route': _routeMetadata(route),
      if (previousRoute != null) 'previousRoute': _routeMetadata(previousRoute),
    });

    _updateContext(previousRoute);
    callbacks.didRemoveRoute(
      newRoute: previousRoute,
      previousRoute: route,
      navigatorName: navigatorName,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _leaveBreadcrumb('Route popped off', {
      'route': _routeMetadata(route),
      if (previousRoute != null) 'previousRoute': _routeMetadata(previousRoute),
    });

    _updateContext(previousRoute);
    callbacks.didPopRoute(
      newRoute: previousRoute,
      previousRoute: route,
      navigatorName: navigatorName,
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _leaveBreadcrumb('Route pushed on', {
      'route': _routeMetadata(route),
      if (previousRoute != null) 'previousRoute': _routeMetadata(previousRoute),
    });

    _updateContext(route);
    callbacks.didPushNewRoute(
      newRoute: route,
      previousRoute: previousRoute,
      navigatorName: navigatorName,
    );
  }

  void _leaveBreadcrumb(String function, Map<String, Object> metadata) {
    if (leaveBreadcrumbs) {
      callbacks.leaveBreadcrumb(
        operationDescription: _operationDescription(function),
        metadata: metadata,
      );
    }
  }

  void _updateContext(Route<dynamic>? newRoute) {
    if (setContext) {
      callbacks
          .setContext(newRoute != null ? _routeDescription(newRoute) : null);
    }
  }

  String _operationDescription(String operation) {
    return '$operation ${navigatorName ?? 'navigator'}';
  }

  static Map<String, Object> _routeMetadata(Route<dynamic> route) {
    return {
      'name': _routeDescription(route),
      if (route.settings.arguments != null)
        'arguments': route.settings.arguments ?? const <String, dynamic>{}
    };
  }

  static String _routeDescription(Route<dynamic> route) {
    final name = route.settings.name;
    if (name != null) return name;

    try {
      String? title = (route as dynamic).title;
      if (title != null) return title;
    } catch (_) {}

    try {
      String? debugLabel = (route as dynamic).debugLabel;
      if (debugLabel != null) return debugLabel;
    } catch (_) {}

    return route.toString();
  }
}
