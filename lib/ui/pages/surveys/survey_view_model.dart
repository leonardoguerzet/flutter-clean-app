import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyViewModel extends Equatable {
  final String id;
  final String question;
  final String dateTime;
  final bool didAnswer;

  List get props => ['id', 'question', 'dateTime', 'didAnswer'];

  SurveyViewModel({
    @required this.id,
    @required this.question,
    @required this.dateTime,
    @required this.didAnswer,
  });
}
