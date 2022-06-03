import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String? urlEndpoint;
  final String? buildFlavor;
  @override
  final Widget child;

  const AppConfig(
      {required this.urlEndpoint,
        required this.buildFlavor,
        required this.child}) : super(child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
