import '../helpers.dart';

enum UIError {
  requiredField,
  invalidCredentials,
  invalidField,
  unexpected,
}

extension UIErrorExtension on UIError {
  String get description {
    switch(this){
      case UIError.requiredField: return R.strings.msgRequiredField ;
      case UIError.invalidCredentials: return R.strings.msgInvalidCredentials;
      case UIError.invalidField: return R.strings.msgInvalidField;
      default: return R.strings.msgUnexpected;
    }
  }

}