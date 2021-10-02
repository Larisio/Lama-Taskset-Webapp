import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/app.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => {},
    child: LamaAppWebApp(),
  ));
}
