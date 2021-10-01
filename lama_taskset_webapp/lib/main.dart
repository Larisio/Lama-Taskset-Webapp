import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/app.dart';
import 'package:lama_taskset_webapp/src/bloc/homeScreenBloc/home_screen_bloc.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => {},
    child: LamaAppWebApp(),
  ));
}
