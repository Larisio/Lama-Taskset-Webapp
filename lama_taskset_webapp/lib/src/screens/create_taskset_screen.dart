import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_event.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_state.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';
import 'package:lama_taskset_webapp/src/utils/widgets/edits_taskset.dart';

///provides view to:
/// - configurat an taskset
/// - edit/add/delete tasks in this taskset
/// - donwload the taskset as JSON-File
///
/// * see also
///    [CreateTasksetBloc]
///    [CreateTasksetEvent]
///    [CreateTasksetState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 06.10.2021
class CreateTasksetScreen extends StatefulWidget {
  CreateTasksetScreen({Key? key}) : super(key: key);
  @override
  _CreateTasksetScreenState createState() => _CreateTasksetScreenState();
}

///provides state for [CreateTasksetScreen]
///
/// * see also
///    [CreateTasksetBloc]
///    [CreateTasksetEvent]
///    [CreateTasksetState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 06.10.2021
class _CreateTasksetScreenState extends State<CreateTasksetScreen> {
  //used to adjust the with of the sidebar
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
          ///Als JSON Runterladen Button
          ElevatedButton.icon(
            onPressed: () => {
              context.read<CreateTasksetBloc>().add(TasksetJsonDownloadEvent())
            },
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
          ///Sidebar
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

          ///Main view
          Expanded(
            child: BlocBuilder<CreateTasksetBloc, CreateTasksetState>(
              builder: (context, state) {
                if (state is EditTasksetState)
                  return EditTaskset(taskset: state.taskset);
                if (state is ViewAvailableTasksTasksetState)
                  return _availibleTasksList(context, state.taskset);
                if (state is EditTaskInTasksetState) {
                  return _editTask(context, state.task);
                }
                if (state is ErrorTasksetState)
                  return _errorScreen(context, state.error);
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  ///(private)
  ///
  ///provides button to switch to the "edit taskset view",
  ///were the taskset metaData can been changed
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

  ///(private)
  ///
  ///button to add an task to the taskset
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

  ///(private)
  ///
  ///button to delete an specific task in the taskset
  Widget _deleteTaskButton(BuildContext context, Task task) {
    return ElevatedButton.icon(
      onPressed: () =>
          context.read<CreateTasksetBloc>().add(DeleteTaskInTasksetEvent(task)),
      icon: Icon(Icons.delete),
      label: Text(
        "Aufgabe entfernen",
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(_sideBarWith, 60),
        primary: UtilsColors.redPrimary,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }

  ///(private)
  ///
  ///provides view to edit an sepcific task in the taskset
  Widget _editTask(BuildContext context, Task task) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: UtilsColors.greyAccent,
            height: 800,
            width: 500,
            child: task.view(context),
          ),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: UtilsColors.greyAccent,
                height: 500,
                width: 500,
                child: task.headView(context),
              ),
              SizedBox(height: 25),
              _deleteTaskButton(context, task),
            ],
          ),
        ],
      ),
    );
  }

  ///(private)
  ///
  ///basic error screen
  Widget _errorScreen(BuildContext context, String? errorMessage) {
    return Center(
      child: Text(errorMessage ?? "Unbestimmter Fehler!"),
    );
  }

  ///(private)
  ///
  ///used to show all availible tasks for this subject
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

  ///(private)
  ///
  ///provides list of all tasks in the taskset
  ///used in the sidebar
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
                      index: index,
                      errorCheck: true),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
