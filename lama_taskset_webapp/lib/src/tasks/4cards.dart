import 'package:flutter/material.dart';
import 'package:lama_taskset_webapp/src/tasks/task.dart';
import 'package:lama_taskset_webapp/src/utils/input_validation.dart';
import 'package:lama_taskset_webapp/src/utils/lama_text_theme.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';

abstract class FourCardsFields {
  static final String question = "question";
  static final String rightAnswer = "right_answer";
  static final String wrongAnswers = "wrong_answers";
}

// ignore: must_be_immutable
class FourCards extends Task {
  String? question;
  String? rightAnswer;
  List<String> wrongAnswers = ["falsch", "falsch", "falsch"];

  FourCards(
      {this.question,
      this.rightAnswer,
      taskTyp = "4Cards",
      taskReward = 2,
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
    return Form(
      key: formKeyChild,
      child: Column(
        children: [
          _oragneBox(),
          _cardsOneBox(),
          SizedBox(height: 50),
          _cardsTwoBox()
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
  String? isValid() {
    if (headIsValid() != null) return headIsValid();
    if (InputValidation.isEmpty(question)) return "Frage darf nicht leer sein!";
    if (InputValidation.isEmpty(rightAnswer))
      return "Richtige Antwort darf nicht leer sein";
    for (int i = 0; i < wrongAnswers.length; i++) {
      if (InputValidation.isEmpty(wrongAnswers[i]))
        return "Falsche Antworten dürfen nicht leer sein! \n Antwort ${i + 1} fehlt!";
    }
    return null;
  }

  @override
  Task getCopy() {
    return new FourCards(
        question: this.question,
        rightAnswer: this.rightAnswer,
        taskTyp: this.taskTyp,
        taskReward: this.taskReward,
        lamaText: this.lamaText,
        leftToSolve: this.leftToSolve);
  }

  Widget _oragneBox() {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 50, 50, 25),
      height: 275,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          gradient: LinearGradient(
            colors: [UtilsColors.orangeAccent, UtilsColors.orangePrimary],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Align(
          child: TextFormField(
            initialValue: question,
            validator: (value) => InputValidation.inputFieldIsEmpty(value),
            onChanged: (value) => {question = value},
            style: LamaTextTheme.getStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _cardsOneBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: UtilsColors.greenAccent,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextFormField(
            initialValue: rightAnswer,
            validator: (value) => InputValidation.inputFieldIsEmpty(value),
            onChanged: (value) => {rightAnswer = value},
            style: LamaTextTheme.getStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 50),
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: UtilsColors.redAccent,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextFormField(
            initialValue: wrongAnswers[0],
            validator: (value) => InputValidation.inputFieldIsEmpty(value),
            onChanged: (value) => {wrongAnswers[0] = value},
            style: LamaTextTheme.getStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _cardsTwoBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: UtilsColors.redAccent,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextFormField(
            initialValue: wrongAnswers[1],
            validator: (value) => InputValidation.inputFieldIsEmpty(value),
            onChanged: (value) => {wrongAnswers[1] = value},
            style: LamaTextTheme.getStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 50),
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: UtilsColors.redAccent,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextFormField(
            initialValue: wrongAnswers[2],
            validator: (value) => InputValidation.inputFieldIsEmpty(value),
            onChanged: (value) => {wrongAnswers[2] = value},
            style: LamaTextTheme.getStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
