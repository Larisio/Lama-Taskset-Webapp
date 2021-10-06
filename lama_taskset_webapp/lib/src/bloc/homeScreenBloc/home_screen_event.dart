import 'package:flutter/cupertino.dart';

/// Author: L.Kammerer
/// latest Changes: 01.10.2021
abstract class HomeScreenEvent {}

class HomeScreenCreateTasksetEvent extends HomeScreenEvent {
  BuildContext context;
  HomeScreenCreateTasksetEvent(this.context);
}
