import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lama_taskset_webapp/src/utils/input_validation.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';

abstract class TaskFields {
  static final String taskTyp = 'task_type';
  static final String taskReward = 'task_reward';
  static final String lamaText = 'lama_text';
  static final String leftToSolve = 'left_to_solve';
}

abstract class Task {
  final String taskTyp;
  int taskReward;
  String lamaText;
  int leftToSolve;
  //[_formKey] should be used to identify every Form in this Screen
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyChild = GlobalKey<FormState>();

  Task(
      {required this.taskTyp,
      required this.taskReward,
      required this.lamaText,
      required this.leftToSolve});

  Widget view(BuildContext context);
  Widget headView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              taskTyp,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: UtilsColors.greyPrimary),
            ),
            SizedBox(height: 20),
            Text("Lama Text"),
            TextFormField(
              initialValue: lamaText,
              decoration:
                  InputDecoration(hintText: 'Feld darf nicht leer sein'),
              validator: (value) => InputValidation.inputFieldIsEmpty(value),
              textAlign: TextAlign.center,
              onChanged: (value) => lamaText = value,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Belohnung für das Lösen der Aufgabe: "),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: taskReward.toString(),
                    decoration: InputDecoration(hintText: '0'),
                    validator: (value) {
                      int? check;
                      check = int.tryParse(value!);
                      if (check == null || check <= 0)
                        return "Zahlenwert zu klein!";
                      return null;
                    },
                    textAlign: TextAlign.center,
                    onChanged: (value) => int.tryParse(value) != null
                        ? taskReward = int.tryParse(value)!
                        : taskReward = 0,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Lösen der Aufgabe mit Belohnung: "),
                Container(
                  width: 100,
                  child: TextFormField(
                    initialValue: leftToSolve.toString(),
                    decoration: InputDecoration(hintText: '0'),
                    validator: (value) {
                      int? check;
                      check = int.tryParse(value!);
                      if (check == null || check <= 0)
                        return "Zahlenwert zu klein!";
                      return null;
                    },
                    textAlign: TextAlign.center,
                    onChanged: (value) => int.tryParse(value) != null
                        ? leftToSolve = int.tryParse(value)!
                        : leftToSolve = 0,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  "*Gibt an wie oft die Aufgabe MIT Belohnung gelöst werden darf.",
                  style:
                      TextStyle(fontSize: 12, color: UtilsColors.greyPrimary),
                ),
              ],
            ),
            SizedBox(width: 15),
            TextButton(
              child: Text("Fertig"),
              onPressed: () {
                _formKey.currentState!.validate();
                formKeyChild.currentState!.validate();
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150, 50))),
            )
          ],
        ),
      ),
    );
  }

  ListTile listTile({GestureTapCallback? function, bool errorCheck = false});
  Map<String, dynamic> toJson() => toMap();
  Map<String, dynamic> toMap();
  String? headIsValid() {
    if (taskReward < 0) return "head error";
  }

  String? isValid();

  Task getCopy();
}
