import 'package:lama_taskset_webapp/src/subjects/math.dart';
import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/input_validation.dart';

///Definition of all field which are used or could be used to create an full Taskset
///
///Author: L. Kammerer
///Last changes: 06.10.2021
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
///Last changes: 06.10.2021
class Taskset {
  String? name;
  Subject subject = MathSubject();
  int grade;
  //List of all tasks in the taskset
  List<Task> tasks = [];
  bool randomizeOrder;
  int? chooseAmount;

  //collection of all availible grades
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

  ///used to validate the taskset including all tasks
  String? isValid() {
    if (InputValidation.isEmpty(name))
      return "Names des Aufgabenpakets darf nicht leer sein!";
    if (chooseAmount == null || chooseAmount! > tasks.length)
      return "Anzahl zufällig genutzer Aufgaben darf nicht höher sein als die Aufgabenanzahl!";
    if (tasks.length == 0) return "Aufgabenpaket enthält keine Aufgaben!";
    for (int i = 0; i < tasks.length; i++) {
      String? check = tasks[i].isValid();
      if (check != null)
        return "Fehler in Aufgabe! \n Nummer: ${i + 1} \n Typ: ${tasks[i].taskTyp} \n Hinweis: $check";
    }
    return null;
  }

  ///used to encode object to JSON
  Map<String, dynamic> toJson() => toMap();

  ///used to encode the Object to JSON
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      TasksetFields.tasksetName: name,
      TasksetFields.tasksetSubject: subject.name,
      TasksetFields.tasksetGrade: grade + 1
    };
    //excluding optional params
    if (randomizeOrder)
      map.addAll(<String, dynamic>{
        TasksetFields.tasksetRandomizeOrder: randomizeOrder
      });
    if (chooseAmount != null && chooseAmount! > 0)
      map.addAll(
          <String, dynamic>{TasksetFields.tasksetChooseAmount: chooseAmount});
    //append all tasks
    map.addAll(<String, dynamic>{TasksetFields.tasks: tasks});
    return map;
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
