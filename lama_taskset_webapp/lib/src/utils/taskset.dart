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
  String? name;
  Subject subject = MathSubject();
  int grade;
  List<Task> tasks = [];
  List<String> test = [];
  bool randomizeOrder;
  int? chooseAmount;

  static final List<String> legalGrades = [
    "Klasse 1",
    "Klasse 2",
    "Klasse 3",
    "Klasse 4",
    "Klasse 5",
    "Klasse 6",
  ];

  Taskset(
      {this.name,
      this.grade = 0,
      tasksetSubject,
      this.randomizeOrder = false,
      this.chooseAmount = 0}) {
    this.subject = tasksetSubject ?? MathSubject();
  }

  Map<String, dynamic> toJson() => toMap();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TasksetFields.tasksetName: name,
      TasksetFields.tasksetSubject: subject,
      TasksetFields.tasksetGrade: grade,
      TasksetFields.tasks: tasks,
      TasksetFields.tasksetRandomizeOrder: randomizeOrder,
      TasksetFields.tasksetChooseAmount: chooseAmount
    };
  }

  String toString() {
    String line = "\n ---------------------------------------------------- \n";
    String legalSubjectLength = subject.legalTasks.length.toString();
    int tasksLength = tasks.length;
    String subjectName = subject.name;
    return line +
        '\n Name: $name \n Subject: $subjectName ($legalSubjectLength) \n Grade: $grade \n Tasks: $tasksLength \n ChooseAmount: $chooseAmount \n RandonOrder: $randomizeOrder \n' +
        line;
  }
}
