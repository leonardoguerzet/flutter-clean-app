import 'package:meta/meta.dart';

import '../../data/usecases/usecases.dart';
import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

class RemoteLoadSurveysWithLocalFallback implements LoadSurveys {
  final RemoteLoadSurveys remote;
  final LocalLoadSurveys local;

  RemoteLoadSurveysWithLocalFallback({
    @required this.remote,
    @required this.local,
  });

  Future<List<SurveyEntity>> loadBySurvey() async {
    try {
      final surveys = await remote.loadBySurvey();
      await local.save(surveys);
      return surveys;
    } catch(error){
      if(error == DomainError.accessDenied){
        rethrow;
      }
      await local.validate();
      return await local.loadBySurvey();
    }
  }
}