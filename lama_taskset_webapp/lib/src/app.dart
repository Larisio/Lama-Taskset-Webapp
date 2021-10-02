import 'package:flutter/material.dart';
import 'package:lama_taskset_webapp/src/router.dart';

class LamaAppWebApp extends MaterialApp {
  LamaAppWebApp()
      : super(
          debugShowCheckedModeBanner: false,
          title: "LAMA WEBAPP",
          initialRoute: WebAppRouter.homeRoute,
          routes: WebAppRouter.routes,
        );
}
