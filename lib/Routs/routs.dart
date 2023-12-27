import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../views/home.dart';
import '../views/startup.dart';

class Routes {
  static FluroRouter router = FluroRouter();

  static void configureRoutes() {
    router.define(
      '/',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            Home(),
      ),
    );

  }

   static void navigateTo(BuildContext context, String route) {
    router.navigateTo(context, route, transition: TransitionType.fadeIn);
  }
}