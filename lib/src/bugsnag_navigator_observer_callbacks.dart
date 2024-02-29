import 'package:flutter/widgets.dart';

typedef LeaveBreadcrumbCallback = Function(
  String operationDescription,
  Map<String, Object> metadata,
);
typedef SetContextCallback = Function(String? context);
typedef WillShowNewRouteCallback = Function(
    Route<dynamic>? newRoute, String? routeDescription);

class BugsnagNavigatorObserverCallbacks {
  LeaveBreadcrumbCallback? _leaveBreadcrumbCallback;
  SetContextCallback? _setContextCallback;
  WillShowNewRouteCallback? _willShowNewRouteCallback;

  void leaveBreadcrumb({
    required String operationDescription,
    required Map<String, Object> metadata,
  }) {
    if (_leaveBreadcrumbCallback != null) {
      _leaveBreadcrumbCallback!(operationDescription, metadata);
    }
  }

  void setContext(String? context) {
    if (_setContextCallback != null) {
      _setContextCallback!(context);
    }
  }

  void willShowNewRoute({
    Route<dynamic>? newRoute,
    String? routeDescription,
  }) {
    if (_willShowNewRouteCallback != null) {
      _willShowNewRouteCallback!(newRoute, routeDescription);
    }
  }

  static setup({
    LeaveBreadcrumbCallback? leaveBreadcrumbCallback,
    SetContextCallback? setContextCallback,
    WillShowNewRouteCallback? willShowNewRouteCallback,
  }) {
    if (leaveBreadcrumbCallback != null) {
      callbacks._leaveBreadcrumbCallback = leaveBreadcrumbCallback;
    }
    if (setContextCallback != null) {
      callbacks._setContextCallback = setContextCallback;
    }
    if (willShowNewRouteCallback != null) {
      callbacks._willShowNewRouteCallback = willShowNewRouteCallback;
    }
  }
}

final callbacks = BugsnagNavigatorObserverCallbacks();
