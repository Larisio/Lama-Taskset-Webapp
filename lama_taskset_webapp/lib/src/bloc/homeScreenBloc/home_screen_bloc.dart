import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/router.dart';
import 'package:lama_taskset_webapp/src/screens/create_taskset_screen.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

///[Bloc] for the [CreateTasksetScreen]
///
/// * see also
///    [HomeScreen]
///    [HomeScreenEvent]
///    [HomeScreenState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 01.10.2021
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState());

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is HomeScreenCreateTasksetEvent) _createTaskset(event.context);
  }

  void _createTaskset(BuildContext context) {
    Navigator.pushReplacementNamed(context, WebAppRouter.createTaskset);
  }
}
