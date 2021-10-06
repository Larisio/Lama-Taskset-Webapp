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
/// Latest Changes: 06.10.2021
class CreateTasksetBloc extends Bloc<CreateTasksetEvent, CreateTasksetState> {
  CreateTasksetBloc() : super(EditTasksetState(Taskset()));
  Taskset taskset = Taskset();

  @override
  Stream<CreateTasksetState> mapEventToState(CreateTasksetEvent event) async* {
    if (event is TasksetJsonDownloadEvent) yield _download();

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
    if (event is DeleteTaskInTasksetEvent) {
      taskset.tasks.remove(event.task);
      yield EmptyTasksetState(taskset);
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
          ? taskset.chooseAmount = 0
          : taskset.chooseAmount = int.tryParse(event.pickAmount);
    if (event is CTChangeRandomOrderEvent)
      taskset.randomizeOrder = event.randomOrder ?? false;
  }

  ///(private)
  ///
  ///used to start an donwload of the taskset as JSON-File
  ///@importand [ErrorTasksetState] is triggerd if the validation isn't successfull!
  CreateTasksetState _download() {
    if (taskset.isValid() != null)
      return ErrorTasksetState(taskset, taskset.isValid());
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
    return EmptyTasksetState(taskset);
  }
}
