import 'package:flutter/widgets.dart';

typedef LeaveBreadcrumbCallback = Function(
  String operationDescription,
  Map<String, Object> metadata,
);
typedef SetContextCallback = Function(String? context);
typedef WillShowNewRouteCallback = Function(
  Route<dynamic>? newRoute,
  Route<dynamic>? previousRoute,
  String? navigatorName,
);

class BugsnagNavigatorObserverCallbacks {
  LeaveBreadcrumbCallback? _leaveBreadcrumbCallback;
  SetContextCallback? _setContextCallback;
  WillShowNewRouteCallback? _didPushNewRouteCallback;
  WillShowNewRouteCallback? _didReplaceRouteCallback;
  WillShowNewRouteCallback? _didRemoveRouteCallback;
  WillShowNewRouteCallback? _didPopRouteCallback;

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
    String? navigatorName,
  }) {
    if (_didPushNewRouteCallback != null) {
      _didPushNewRouteCallback!(
        newRoute,
        previousRoute,
        navigatorName,
      );
    }
  }

  void didReplaceRoute({
    Route<dynamic>? newRoute,
    Route<dynamic>? previousRoute,
    String? navigatorName,
  }) {
    if (_didReplaceRouteCallback != null) {
      _didReplaceRouteCallback!(
        newRoute,
        previousRoute,
        navigatorName,
      );
    }
  }

  void didRemoveRoute({
    Route<dynamic>? newRoute,
    Route<dynamic>? previousRoute,
    String? navigatorName,
  }) {
    if (_didRemoveRouteCallback != null) {
      _didRemoveRouteCallback!(
        newRoute,
        previousRoute,
        navigatorName,
      );
    }
  }

  void didPopRoute({
    Route<dynamic>? newRoute,
    Route<dynamic>? previousRoute,
    String? navigatorName,
  }) {
    if (_didPopRouteCallback != null) {
      _didPopRouteCallback!(
        newRoute,
        previousRoute,
        navigatorName,
      );
    }
  }

  static setup({
    LeaveBreadcrumbCallback? leaveBreadcrumbCallback,
    SetContextCallback? setContextCallback,
    WillShowNewRouteCallback? didPushNewRouteCallback,
    WillShowNewRouteCallback? didReplaceRouteCallback,
    WillShowNewRouteCallback? didRemoveRouteCallback,
    WillShowNewRouteCallback? didPopRouteCallback,
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
    if (didRemoveRouteCallback != null) {
      callbacks._didRemoveRouteCallback = didRemoveRouteCallback;
    }
    if (didPopRouteCallback != null) {
      callbacks._didPopRouteCallback = didPopRouteCallback;
    }
  }
}

final callbacks = BugsnagNavigatorObserverCallbacks();
