import 'package:lama_taskset_webapp/src/subjects/math.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';

abstract class Subject {
  static List<Subject> legalSubjects = [new MathSubject()];
  final String name;
  List<Task>? legalTasks = [];

  Subject({required this.name, this.legalTasks});
}
