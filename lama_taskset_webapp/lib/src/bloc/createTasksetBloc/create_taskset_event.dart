abstract class CreateTasksetEvent {}

class EditTasksetEvent extends CreateTasksetEvent {}

class FinishEditTasksetEvent extends CreateTasksetEvent {}

class CTChangeNameEvent extends CreateTasksetEvent {
  String name;
  CTChangeNameEvent(this.name);
}

class CTChangeGradeEvent extends CreateTasksetEvent {
  String? grade;
  CTChangeGradeEvent(this.grade);
}

class CTChangeSubjectEvent extends CreateTasksetEvent {
  String? subject;
  CTChangeSubjectEvent(this.subject);
}

class CTChangePickAmountEvent extends CreateTasksetEvent {
  String pickAmount;
  CTChangePickAmountEvent(this.pickAmount);
}

class CTChangeRandomOrderEvent extends CreateTasksetEvent {
  bool? randomOrder;
  CTChangeRandomOrderEvent(this.randomOrder);
}
