import 'package:flutter/material.dart';

abstract class TaskFields {
  static final String taskTyp = 'task_type';
  static final String taskReward = 'task_reward';
  static final String lamaText = 'lama_text';
  static final String leftToSolve = 'left_to_solve';
}

abstract class Task {
  final String taskTyp;
  final int taskReward;
  final String lamaText;
  final int leftToSolve;

  Task(
      {required this.taskTyp,
      required this.taskReward,
      required this.lamaText,
      required this.leftToSolve});

  Widget view(BuildContext context);
  ListTile listTile({GestureTapCallback? function});
  Map<String, dynamic> toJson() => toMap();
  Map<String, dynamic> toMap();
  bool isValid();
}
