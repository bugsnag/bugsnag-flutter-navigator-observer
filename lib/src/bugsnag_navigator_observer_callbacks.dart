import 'package:flutter/widgets.dart';

typedef LeaveBreadcrumbCallback = Function(
  String operationDescription,
  Map<String, Object> metadata,
);
typedef SetContextCallback = Function(String? context);
typedef WillShowNewRouteCallback = Function(
    Route<dynamic>? newRoute, Route<dynamic>? previousRoute);

class BugsnagNavigatorObserverCallbacks {
  LeaveBreadcrumbCallback? _leaveBreadcrumbCallback;
  SetContextCallback? _setContextCallback;
  WillShowNewRouteCallback? _didPushNewRouteCallback;
  WillShowNewRouteCallback? _didReplaceRouteCallback;

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

  void didPushNewRoute({
    Route<dynamic>? newRoute,
    Route<dynamic>? previousRoute,
  }) {
    if (_didPushNewRouteCallback != null) {
      _didPushNewRouteCallback!(newRoute, previousRoute);
    }
  }

  void didReplaceRoute({
    Route<dynamic>? newRoute,
    Route<dynamic>? previousRoute,
  }) {
    if (_didReplaceRouteCallback != null) {
      _didReplaceRouteCallback!(newRoute, previousRoute);
    }
  }

  static setup({
    LeaveBreadcrumbCallback? leaveBreadcrumbCallback,
    SetContextCallback? setContextCallback,
    WillShowNewRouteCallback? didPushNewRouteCallback,
    WillShowNewRouteCallback? didReplaceRouteCallback,
  }) {
    if (leaveBreadcrumbCallback != null) {
      callbacks._leaveBreadcrumbCallback = leaveBreadcrumbCallback;
    }
    if (setContextCallback != null) {
      callbacks._setContextCallback = setContextCallback;
    }
    if (didPushNewRouteCallback != null) {
      callbacks._didPushNewRouteCallback = didPushNewRouteCallback;
    }
    if (didReplaceRouteCallback != null) {
      callbacks._didReplaceRouteCallback = didReplaceRouteCallback;
    }
  }
}

final callbacks = BugsnagNavigatorObserverCallbacks();
