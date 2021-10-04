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

  FourCards(
      {this.question,
      this.rightAnswer,
      this.wrongAnswers,
      taskTyp = "4Cards",
      taskReward = 4,
      lamaText = "Tippe die Richtige Antwort an!",
      leftToSolve = 3})
      : super(
          taskTyp: taskTyp,
          taskReward: taskReward,
          lamaText: lamaText,
          leftToSolve: leftToSolve,
        );

  @override
  Widget view(BuildContext context) {
    return TextFormField(
      initialValue: question,
      onChanged: (value) => question = value,
    );
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
    return <String, dynamic>{
      TaskFields.taskTyp: taskTyp,
      TaskFields.taskReward: taskReward,
      TaskFields.lamaText: lamaText,
      TaskFields.leftToSolve: leftToSolve,
      //END HEAD
      FourCardsFields.question: question,
      FourCardsFields.rightAnswer: rightAnswer,
      FourCardsFields.wrongAnswers: wrongAnswers
    };
  }

  @override
  bool isValid() {
    return true;
  }

  @override
  Task getCopy() {
    return new FourCards(
        question: this.question,
        rightAnswer: this.rightAnswer,
        wrongAnswers: this.wrongAnswers,
        taskTyp: this.taskTyp,
        taskReward: this.taskReward,
        lamaText: this.lamaText,
        leftToSolve: this.leftToSolve);
  }
}
