// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_bloc.dart';
import 'package:lama_taskset_webapp/src/bloc/createTasksetBloc/create_taskset_event.dart';
import 'package:lama_taskset_webapp/src/subjects/subject.dart';
import 'package:lama_taskset_webapp/src/utils/input_validation.dart';
import 'package:lama_taskset_webapp/src/utils/taskset.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class EditTaskset extends StatefulWidget {
  Taskset taskset = Taskset();

  EditTaskset({taskset}) {
    this.taskset = taskset ?? Taskset();
  }

  @override
  State<StatefulWidget> createState() {
    return _EditTaskState(taskset: taskset);
  }
}

class _EditTaskState extends State<EditTaskset> {
  Taskset taskset = Taskset();
  //[_formKey] should be used to identify every Form in this Screen
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //temporary save the value of the Dropdown menu
  String? _dropdownGradeValue = Taskset.legalGrades[Taskset().grade];
  String? _dropdownSubjectValue = Taskset().subject.name;
  bool _checkboxRandomOrder = Taskset().randomizeOrder;

  _EditTaskState({taskset}) {
    this.taskset = taskset ?? Taskset();
    _dropdownGradeValue = Taskset.legalGrades[this.taskset.grade];
    _dropdownSubjectValue = this.taskset.subject.name;
    _checkboxRandomOrder = this.taskset.randomizeOrder;
  }

  @override
  Widget build(BuildContext context) {
    return _editTaskset(context, taskset);
  }

  Widget _editTaskset(BuildContext context, Taskset taskset) {
    return Center(
      child: Container(
        height: 530,
        width: 500,
        color: UtilsColors.greyAccent,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "Aufgabenpaket editieren",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: UtilsColors.greyPrimary),
                ),
                SizedBox(height: 25),
                _nameInput(context, taskset),
                SizedBox(height: 50),
                _rowSubjectGade(context, taskset),
                SizedBox(height: 50),
                Text(
                  "Optionale Einstellungen",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: UtilsColors.greyPrimary),
                ),
                _optionalSettings(context, taskset),
                SizedBox(height: 25),
                TextButton(
                  child: Text("Fertig"),
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      context
                          .read<CreateTasksetBloc>()
                          .add(FinishEditTasksetEvent())
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(150, 50))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _nameInput(BuildContext context, Taskset taskset) {
    return TextFormField(
      initialValue: taskset.name,
      decoration: InputDecoration(hintText: 'Name des Aufgabenpakets'),
      validator: (value) => InputValidation.inputFieldIsEmpty(value),
      onChanged: (value) =>
          context.read<CreateTasksetBloc>().add(CTChangeNameEvent(value)),
      textAlign: TextAlign.center,
    );
  }

  Row _rowSubjectGade(BuildContext context, Taskset taskset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dropdownGrades(context, taskset),
        SizedBox(width: 50),
        _dropdownSubjects(context, taskset)
      ],
    );
  }

  Widget _optionalSettings(BuildContext context, Taskset taskset) {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            Text("Anzahl zufällig genutzer Aufgaben: "),
            Container(
              width: 50,
              child: TextFormField(
                initialValue: taskset.chooseAmount != null
                    ? taskset.chooseAmount.toString()
                    : '0',
                decoration: InputDecoration(hintText: '0'),
                validator: (value) => null,
                textAlign: TextAlign.center,
                onChanged: (value) => context
                    .read<CreateTasksetBloc>()
                    .add(CTChangePickAmountEvent(value)),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            )
          ],
        ),
        SizedBox(height: 15),
        Text(
          "*Der Wert 0 deaktiviert diese Funktion. Standartmäßig werden alle Aufgaben genutzt.",
          style: TextStyle(fontSize: 12, color: UtilsColors.greyPrimary),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text("Zufällige Reihenfolge: "),
            Checkbox(
              checkColor: Colors.white,
              value: _checkboxRandomOrder,
              onChanged: (bool? value) {
                context
                    .read<CreateTasksetBloc>()
                    .add(CTChangeRandomOrderEvent(value));
                setState(() {
                  _checkboxRandomOrder = value!;
                });
              },
            )
          ],
        ),
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
            context.read<CreateTasksetBloc>().add(CTChangeGradeEvent(value));
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
            context.read<CreateTasksetBloc>().add(CTChangeSubjectEvent(value));
            setState(() {
              _dropdownSubjectValue = value;
            });
          }),
    );
  }
}
