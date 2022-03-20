import 'package:flutter/material.dart';
import 'package:rinjani/views/login.dart';
import 'package:rinjani/views/page/plan.dart';
import 'package:rinjani/views/page/realization.dart';
import 'package:rinjani/views/page/report.dart';

import 'views/home.dart';

class Router {
  static const home = "/";
  static const plan = "/plan";
  static const realization = "/realization";
  static const report = "/report";
  static const loginPage = "/login-page";

  static Route<dynamic> generateRouter(RouteSettings settings) {
    Widget widget = Home();
    switch (settings.name) {
      case plan:
        widget = Plan();
        break;
      case loginPage:
        widget = LoginPage();
        break;
      case realization:
        widget = Realization();
        break;
      case report:
        widget = Report();
        break;
    }
    return MaterialPageRoute(settings: settings,builder: (_) => widget);
  }
}

