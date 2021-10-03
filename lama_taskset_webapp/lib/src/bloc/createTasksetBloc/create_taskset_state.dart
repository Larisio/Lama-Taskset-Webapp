import 'package:lama_taskset_webapp/src/utils/taskset.dart';

abstract class CreateTasksetState {}

class EmptyTasksetState extends CreateTasksetState {}

class EditTasksetState extends CreateTasksetState {
  Taskset taskset;
  EditTasksetState(this.taskset);
}
