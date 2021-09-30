import 'package:flutter/cupertino.dart';

abstract class TaskFields {
  static final String taskTyp = 'task_type';
  static final String taskReward = 'task_reward';
  static final String lamaText = 'lama_text';
  static final String leftToSolve = 'left_to_solve';
}

abstract class Task extends StatelessWidget {
  final String taskTyp;
  final int taskReward;
  final String lamaText;
  final int leftToSolve;

  Task(
      {required this.taskTyp,
      required this.taskReward,
      required this.lamaText,
      required this.leftToSolve});

  Map<String, dynamic> toJson() => toMap();
  Map<String, dynamic> toMap();
}
