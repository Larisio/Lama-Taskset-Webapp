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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: UtilsColors.bluePrimary),
      body: Row(
        children: [
          Column(
            children: [
              _editTasksetButton(context),
              BlocBuilder<CreateTasksetBloc, CreateTasksetState>(
                  builder: (context, state) {
                return Expanded(
                  child: Text("d"),
                );
              }),
            ],
          ),
          BlocBuilder<CreateTasksetBloc, CreateTasksetState>(
            builder: (context, state) {
              if (state is EditTasksetState)
                return Expanded(child: EditTaskset(taskset: state.taskset));
              return Container();
            },
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
        minimumSize: Size(275, 60),
        primary: UtilsColors.bluePrimary,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    );
  }
}
