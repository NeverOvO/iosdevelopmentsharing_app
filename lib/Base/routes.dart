
import 'package:flutter/material.dart';
import 'package:iosdevelopmentsharing_app/Index/Controller/IndexViewController.dart';


final routes = {


  //首页/最新
  '/IndexViewController': (context, {arguments}) =>IndexViewController(arguments: arguments),
};

// ignore: top_level_function_literal_block, missing_return
var onGenerateRoute = (RouteSettings settings){
  final String name = settings.name;

  final Function pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
