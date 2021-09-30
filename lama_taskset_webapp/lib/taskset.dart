import 'package:lama_taskset_webapp/tasks/task.dart';

///Definition of all field which are used or could be used to create an full Taskset
///
///Author: L. Kammerer
///Last changes: 30.09.2021
abstract class TasksetFields {
  static final String tasksetName = 'taskset_name';
  static final String tasksetSubject = 'taskset_subject';
  static final String tasksetGrade = 'taskset_grade';
  static final String tasks = 'tasks';
  static final String tasksetRandomizeOrder = 'taskset_randomize_order';
  static final String tasksetChooseAmount = 'taskset_choose_amount';
}

///Definition of an full Taskset
///
///Author: L. Kammerer
///Last changes: 30.09.2021
class Taskset {
  String tasksetName;
  String tasksetSubject;
  int tasksetGrade;
  List<Task> tasks = [];
  bool tasksetRandomizeOrder;
  int tasksetChooseAmount;

  Taskset(
      {required this.tasksetName,
      required this.tasksetSubject,
      required this.tasksetGrade,
      this.tasks = const [],
      this.tasksetRandomizeOrder = false,
      this.tasksetChooseAmount = -1});

  Map<String, dynamic> toJson() => toMap();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TasksetFields.tasksetName: tasksetName,
      TasksetFields.tasksetSubject: tasksetSubject,
      TasksetFields.tasksetGrade: tasksetGrade,
      TasksetFields.tasks: tasks,
      TasksetFields.tasksetRandomizeOrder: tasksetRandomizeOrder,
      TasksetFields.tasksetChooseAmount: tasksetChooseAmount
    };
  }
}
