import 'package:lama_taskset_webapp/src/tasks/task.dart';

/// Author: L.Kammerer
/// Latest Changes: 06.10.2021
abstract class CreateTasksetEvent {}

///donwload trigger
class TasksetJsonDownloadEvent extends CreateTasksetEvent {}

//Editing Events
class EditTasksetEvent extends CreateTasksetEvent {}

class FinishEditTasksetEvent extends CreateTasksetEvent {}

//Add Task Events
class ShowAddibleTasksEvent extends CreateTasksetEvent {}

class AddTaskToTasksetEvent extends CreateTasksetEvent {
  Task task;
  AddTaskToTasksetEvent(this.task);
}

class DeleteTaskInTasksetEvent extends CreateTasksetEvent {
  Task task;
  DeleteTaskInTasksetEvent(this.task);
}

class EditTaskInTasksetEvent extends CreateTasksetEvent {
  int taskIndex;
  EditTaskInTasksetEvent(this.taskIndex);
}

//Change event for taskset data
class CTChangeNameEvent extends CreateTasksetEvent {
  String name;
  CTChangeNameEvent(this.name);
}

class CTChangeGradeEvent extends CreateTasksetEvent {
  String? grade;
  CTChangeGradeEvent(this.grade);
}

class CTChangeSubjectEvent extends CreateTasksetEvent {
  String? subject;
  CTChangeSubjectEvent(this.subject);
}

class CTChangePickAmountEvent extends CreateTasksetEvent {
  String pickAmount;
  CTChangePickAmountEvent(this.pickAmount);
}

class CTChangeRandomOrderEvent extends CreateTasksetEvent {
  bool? randomOrder;
  CTChangeRandomOrderEvent(this.randomOrder);
}
