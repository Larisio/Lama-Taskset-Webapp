import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';

abstract class CreateTasksetState {}

class EmptyTasksetState extends CreateTasksetState {}

class EditTasksetState extends CreateTasksetState {
  Taskset taskset;
  EditTasksetState(this.taskset);
}

class EditTaskInTaskset extends CreateTasksetState {
  Task task;
  EditTaskInTaskset(this.task);
}

class ViewAvailableTasksTasksetState extends CreateTasksetState {
  Taskset taskset;
  ViewAvailableTasksTasksetState(this.taskset);
}
