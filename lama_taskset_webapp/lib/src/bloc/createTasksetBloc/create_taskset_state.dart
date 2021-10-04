import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';

abstract class CreateTasksetState {
  Taskset taskset;
  CreateTasksetState(this.taskset);
}

class EmptyTasksetState extends CreateTasksetState {
  Taskset taskset;
  EmptyTasksetState(this.taskset) : super(taskset);
}

class EditTasksetState extends CreateTasksetState {
  Taskset taskset;
  EditTasksetState(this.taskset) : super(taskset);
}

class EditTaskInTasksetState extends CreateTasksetState {
  Taskset taskset;
  Task task;
  EditTaskInTasksetState(this.task, this.taskset) : super(taskset);
}

class ViewAvailableTasksTasksetState extends CreateTasksetState {
  Taskset taskset;
  ViewAvailableTasksTasksetState(this.taskset) : super(taskset);
}
