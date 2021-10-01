import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/screens/home_screen.dart';
import 'package:lama_taskset_webapp/utils/util_colors.dart';

import 'bloc/homeScreenBloc/home_screen_bloc.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: UtilsColors.bluePrimary,
      ),
      home: BlocProvider(
        create: (BuildContext context) => HomeScreenBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
