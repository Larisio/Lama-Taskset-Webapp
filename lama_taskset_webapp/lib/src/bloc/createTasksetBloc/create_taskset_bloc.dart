import 'dart:convert';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';

import 'create_taskset_event.dart';
import 'create_taskset_state.dart';

///[Bloc] for the [CreateTasksetScreen]
///
/// * see also
///    [CreateTasksetScreen]
///    [CreateTasksetEvent]
///    [CreateTasksetState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 14.07.2021
class CreateTasksetBloc extends Bloc<CreateTasksetEvent, CreateTasksetState> {
  CreateTasksetBloc() : super(EditTasksetState(Taskset()));
  Taskset taskset = Taskset();

  @override
  Stream<CreateTasksetState> mapEventToState(CreateTasksetEvent event) async* {
    if (event is TasksetJsonDownloadEvent) _download();

    //Edit Taskset Events
    if (event is EditTasksetEvent) yield EditTasksetState(taskset);
    if (event is FinishEditTasksetEvent) {
      print(taskset.isValid());
      yield EmptyTasksetState(taskset);
    }

    //Add task Events
    if (event is ShowAddibleTasksEvent)
      yield ViewAvailableTasksTasksetState(taskset);
    if (event is AddTaskToTasksetEvent) {
      taskset.tasks.add(event.task.getCopy());
      yield EditTaskInTasksetState(taskset.tasks.last, taskset);
    }
    if (event is EditTaskInTasksetEvent) {
      yield EmptyTasksetState(taskset);
      await Future.delayed(Duration(milliseconds: 30));
      yield EditTaskInTasksetState(taskset.tasks[event.taskIndex], taskset);
    }

    ///Change events
    if (event is CTChangeNameEvent) taskset.name = event.name;
    if (event is CTChangeGradeEvent)
      taskset.grade =
          Taskset.legalGrades.indexOf(event.grade ?? 'Klasse 1') + 1;
    if (event is CTChangeSubjectEvent)
      taskset.subject = Subject.legalSubjects
          .where((subject) => subject.name == event.subject)
          .first;
    if (event is CTChangePickAmountEvent)
      int.tryParse(event.pickAmount) == null
          ? taskset.chooseAmount = -1
          : taskset.chooseAmount = int.tryParse(event.pickAmount);
    if (event is CTChangeRandomOrderEvent)
      taskset.randomizeOrder = event.randomOrder ?? false;
  }

  /* void _downloadJSON() {
    print(taskset.toString());
    print(jsonEncode(taskset));

    File file = // generated somewhere
    final rawData = file.readAsBytesSync();
    final content = base64Encode(rawData);
    final anchor = AnchorElement(
      href: "data:application/octet-stream;charset=utf-16le;base64,$content")
    ..setAttribute("download", "${taskset.name}.json")
    ..click();
  }
  */
  void _download() {
    List<int> bytes = utf8.encode(jsonEncode(taskset));
    String downloadName = taskset.name ?? "Aufgabenpaket";
    // Encode our file in base64
    final _base64 = base64Encode(bytes);
    // Create the link with the file
    final anchor =
        AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
          ..target = 'blank';
    // add the name
    anchor.download = downloadName + ".json";
    // trigger download
    document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }
}
