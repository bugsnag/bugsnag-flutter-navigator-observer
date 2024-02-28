# NOTE: This repo is a work in progress and has not yet been released as a production ready package.

# BugSnagNavigatorObserver

A common navigation monitoring component for Bugsnag libraries.

## Usage
Typically you will configure this in you `MaterialApp`, `CupertinoApp`
or `Navigator`:
```dart
return MaterialApp(
  navigatorObservers: [BugsnagNavigatorObserver()],
  initialRoute: '/',
  routes: {
    '/': (context) => const AppHomeWidget(),
```
