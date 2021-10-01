import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/homeScreenBloc/home_screen_state.dart';
import 'package:lama_taskset_webapp/src/screens/home_screen.dart';

import 'bloc/homeScreenBloc/home_screen_bloc.dart';

class LamaAppWebApp extends MaterialApp {
  LamaAppWebApp()
      : super(
          debugShowCheckedModeBanner: false,
          title: "LAMA WEBAPP",
          home: BlocProvider(
            create: (BuildContext context) => HomeScreenBloc(),
            child: HomeScreen(),
          ),
        );
}
