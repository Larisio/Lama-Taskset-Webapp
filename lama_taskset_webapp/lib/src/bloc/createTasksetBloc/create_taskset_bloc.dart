import 'dart:convert';

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
    //Edit Taskset Events
    if (event is EditTasksetEvent) yield EditTasksetState(taskset);
    if (event is FinishEditTasksetEvent) {
      print(taskset.toString());
      print(jsonEncode(taskset));
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
}
