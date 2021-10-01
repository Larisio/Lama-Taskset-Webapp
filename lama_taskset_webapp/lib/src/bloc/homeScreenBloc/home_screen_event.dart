import 'package:flutter/cupertino.dart';

abstract class HomeScreenEvent {}

class HomeScreenCreateTasksetEvent extends HomeScreenEvent {
  BuildContext context;
  HomeScreenCreateTasksetEvent(this.context);
}
