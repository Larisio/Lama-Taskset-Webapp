import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/tasks/4cards.dart';

///* see also
///   [Subject]
///
/// Author: L.Kammerer
/// latest Changes: 06.10.2021
class MathSubject extends Subject {
  MathSubject()
      : super(name: "Mathe", legalTasks: [
          FourCards(),
        ]);
}
