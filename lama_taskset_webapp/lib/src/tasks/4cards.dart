import 'package:flutter/material.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';

abstract class FourCardsFields {
  static final String question = "question";
  static final String rightAnswer = "right_answer";
  static final String wrongAnswers = "wrong_answers";
}

// ignore: must_be_immutable
class FourCards extends Task {
  String? question;
  String? rightAnswer;
  List<String>? wrongAnswers;

  FourCards({this.question, this.rightAnswer, this.wrongAnswers})
      : super(
            taskTyp: "4Cards",
            taskReward: 4,
            lamaText: "Tippe die Richtige Antwort an!",
            leftToSolve: 3);

  @override
  Widget view(BuildContext context) {
    return Text("4Cards");
  }

  @override
  ListTile listTile({GestureTapCallback? function}) {
    return ListTile(
      onTap: function,
      title: Column(
        children: [
          Text(taskTyp),
          question != null ? Text(question ?? "leer") : SizedBox(),
        ],
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  bool isValid() {
    // TODO: implement isValidation
    throw UnimplementedError();
  }
}
