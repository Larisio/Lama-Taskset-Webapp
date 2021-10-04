import 'package:lama_taskset_webapp/src/subjects/german.dart';
import 'package:lama_taskset_webapp/src/subjects/math.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';

abstract class Subject {
  static List<Subject> legalSubjects = [MathSubject(), GermanSubject()];
  final String name;
  List<Task> legalTasks = [];

  Subject({required this.name, required this.legalTasks});
}
