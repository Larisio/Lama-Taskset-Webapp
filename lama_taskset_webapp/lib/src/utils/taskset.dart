import 'package:lama_taskset_webapp/src/subjects/math.dart';
import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';

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
  String? tasksetName;
  Subject? tasksetSubject = MathSubject();
  int tasksetGrade;
  List<Task> tasks = [];
  bool tasksetRandomizeOrder;
  int? tasksetChooseAmount;

  static final List<String> legalGrades = [
    "Klasse 1",
    "Klasse 2",
    "Klasse 3",
    "Klasse 4",
    "Klasse 5",
    "Klasse 6",
  ];

  Taskset(
      {this.tasksetName,
      this.tasksetSubject,
      this.tasksetGrade = 0,
      this.tasks = const [],
      this.tasksetRandomizeOrder = false,
      this.tasksetChooseAmount});

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
