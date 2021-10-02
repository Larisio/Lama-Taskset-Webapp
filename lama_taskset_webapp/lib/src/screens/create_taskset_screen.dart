import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_state.dart';
import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/input_validation.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';

class CreateTasksetScreen extends StatefulWidget {
  CreateTasksetScreen({Key? key}) : super(key: key);
  @override
  _CreateTasksetScreenState createState() => _CreateTasksetScreenState();
}

class _CreateTasksetScreenState extends State<CreateTasksetScreen> {
  //[_formKey] should be used to identify every Form in this Screen
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //temporary save the value of the Dropdown menu
  String? _dropdownGradeValue = Taskset.legalGrades[Taskset().tasksetGrade];
  String? _dropdownSubjectValue = Taskset().tasksetSubject?.name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CreateTasksetBloc, CreateTasksetState>(
        builder: (context, state) {
          return _editTaskset(context, new Taskset());
        },
      ),
    );
  }

  Widget _editTaskset(BuildContext context, Taskset taskset) {
    return Center(
      child: Container(
        height: 500,
        width: 500,
        color: UtilsColors.greyAccent,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                _nameInput(context, taskset),
                SizedBox(height: 50),
                _rowSubjectGade(context, taskset),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _nameInput(BuildContext context, Taskset taskset) {
    return TextFormField(
      initialValue: taskset.tasksetName,
      decoration: InputDecoration(hintText: 'Name des Aufgabenpakets'),
      validator: (value) => InputValidation.inputFieldIsEmpty(value),
      textAlign: TextAlign.center,
    );
  }

  Row _rowSubjectGade(BuildContext context, Taskset taskset) {
    return Row(
      children: [
        _dropdownGrades(context, taskset),
        SizedBox(width: 15),
        _dropdownSubjects(context, taskset)
      ],
    );
  }

  DropdownButtonHideUnderline _dropdownGrades(
      BuildContext context, Taskset taskset) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: _dropdownGradeValue,
          items: Taskset.legalGrades.map((String grade) {
            return DropdownMenuItem<String>(
              value: grade,
              child: Text(
                grade,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _dropdownGradeValue = value;
            });
          }),
    );
  }

  DropdownButtonHideUnderline _dropdownSubjects(
      BuildContext context, Taskset taskset) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: _dropdownSubjectValue,
          items: Subject.legalSubjects.map((Subject subject) {
            return DropdownMenuItem<String>(
              value: subject.name,
              child: Text(
                subject.name,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _dropdownSubjectValue = value;
            });
          }),
    );
  }
}
