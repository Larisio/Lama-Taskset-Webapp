import 'package:lama_taskset_webapp/src/subjects/german.dart';
import 'package:lama_taskset_webapp/src/subjects/math.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';

/// used to descripe an subject for an taskset
///
///
/// Author: L.Kammerer
/// latest Changes: 06.10.2021
abstract class Subject {
  //contains all available subject (list of child classes)
  static final List<Subject> legalSubjects = [MathSubject(), GermanSubject()];
  //name of the taskset
  final String name;
  //contains all available tasks for this subject
  List<Task> legalTasks = [];

  Subject({required this.name, required this.legalTasks});
}
