import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_event.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_state.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';
import 'package:lama_taskset_webapp/src/utils/widgets/edits_taskset.dart';

class CreateTasksetScreen extends StatefulWidget {
  CreateTasksetScreen({Key? key}) : super(key: key);
  @override
  _CreateTasksetScreenState createState() => _CreateTasksetScreenState();
}

class _CreateTasksetScreenState extends State<CreateTasksetScreen> {
  double _sideBarWith = 275;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UtilsColors.bluePrimary,
        actions: [
          ElevatedButton.icon(
            onPressed: () => {},
            icon: Icon(Icons.file_download_outlined),
            label: Text("Als JSON Runterladen"),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(_sideBarWith, 0),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Column(
            children: [
              _editTasksetButton(context),
              _addTaskButton(context),
              BlocBuilder<CreateTasksetBloc, CreateTasksetState>(
                builder: (context, state) {
                  return _tasksetTasksListView(context, state.taskset);
                },
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<CreateTasksetBloc, CreateTasksetState>(
              builder: (context, state) {
                if (state is EditTasksetState)
                  return EditTaskset(taskset: state.taskset);
                if (state is ViewAvailableTasksTasksetState)
                  return _availibleTasksList(context, state.taskset);
                if (state is EditTaskInTasksetState) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: UtilsColors.greyAccent,
                          height: 800,
                          width: 500,
                          child: state.task.view(context),
                        ),
                        SizedBox(width: 15),
                        Container(
                          color: UtilsColors.greyAccent,
                          height: 500,
                          width: 500,
                          child: state.task.headView(context),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _editTasksetButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () =>
          context.read<CreateTasksetBloc>().add(EditTasksetEvent()),
      icon: Icon(Icons.edit),
      label: Text(
        "Aufgabenpaket bearbeiten",
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(_sideBarWith, 60),
        primary: UtilsColors.bluePrimary,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }

  Widget _addTaskButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () =>
          context.read<CreateTasksetBloc>().add(ShowAddibleTasksEvent()),
      icon: Icon(Icons.add),
      label: Text(
        "Aufgabe hinzufügen",
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(_sideBarWith, 60),
        primary: UtilsColors.bluePrimary,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }

  Widget _availibleTasksList(BuildContext context, Taskset taskset) {
    return Center(
      child: Container(
        color: UtilsColors.greyAccent,
        width: _sideBarWith + _sideBarWith,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: taskset.subject.legalTasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: taskset.subject.legalTasks[index].listTile(
                    function: () => {
                      context.read<CreateTasksetBloc>().add(
                            AddTaskToTasksetEvent(
                                taskset.subject.legalTasks[index]),
                          )
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _tasksetTasksListView(BuildContext context, Taskset taskset) {
    return Expanded(
      child: Container(
        color: UtilsColors.greyAccent,
        width: _sideBarWith - 8,
        child: Padding(
          padding: EdgeInsets.all(1),
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: taskset.tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: taskset.tasks[index].listTile(
                    function: () => {
                      context.read<CreateTasksetBloc>().add(
                            EditTaskInTasksetEvent(index),
                          )
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
