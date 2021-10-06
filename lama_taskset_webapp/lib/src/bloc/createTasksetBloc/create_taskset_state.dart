import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';

abstract class CreateTasksetState {
  Taskset taskset;
  CreateTasksetState(this.taskset);
}

//empty state
class EmptyTasksetState extends CreateTasksetState {
  Taskset taskset;
  EmptyTasksetState(this.taskset) : super(taskset);
}

//used to show any kind of error
class ErrorTasksetState extends CreateTasksetState {
  Taskset taskset;
  String? error;
  ErrorTasksetState(this.taskset, this.error) : super(taskset);
}

//used to show the options for changing the taskset meta data
class EditTasksetState extends CreateTasksetState {
  Taskset taskset;
  EditTasksetState(this.taskset) : super(taskset);
}

//editing an specific task in the taskset
class EditTaskInTasksetState extends CreateTasksetState {
  Taskset taskset;
  Task task;
  EditTaskInTasksetState(this.task, this.taskset) : super(taskset);
}

//list all available tasks for this subject
class ViewAvailableTasksTasksetState extends CreateTasksetState {
  Taskset taskset;
  ViewAvailableTasksTasksetState(this.taskset) : super(taskset);
}
