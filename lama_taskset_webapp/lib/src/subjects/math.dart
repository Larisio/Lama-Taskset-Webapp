import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/tasks/4cards.dart';

class MathSubject extends Subject {
  MathSubject() : super(name: "Mathematik", legalTasks: [FourCards()]);
}
