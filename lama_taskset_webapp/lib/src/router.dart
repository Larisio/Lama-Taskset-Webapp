import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/screens/create_taskset_screen.dart';
import 'package:lama_taskset_webapp/src/screens/home_screen.dart';

import 'bloc/createTasksetBloc/create_taskset_bloc.dart';
import 'bloc/homeScreenBloc/home_screen_bloc.dart';

class WebAppRouter {
  static final String homeRoute = "homescreen";
  static final String createTaskset = "createTaskset";

  static final Map<String, WidgetBuilder> routes = {
    homeRoute: (context) => BlocProvider(
          create: (BuildContext context) => HomeScreenBloc(),
          child: HomeScreen(),
        ),
    createTaskset: (context) => BlocProvider(
          create: (BuildContext context) => CreateTasksetBloc(),
          child: CreateTasksetScreen(),
        ),
  };
}
