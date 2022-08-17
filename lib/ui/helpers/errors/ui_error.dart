import '../helpers.dart';

enum UIError {
  requiredField,
  invalidCredentials,
  invalidField,
  unexpected,
  emailInUse,
}

extension UIErrorExtension on UIError {
  String get description {
    switch(this){
      case UIError.requiredField: return R.strings.msgRequiredField ;
      case UIError.invalidCredentials: return R.strings.msgInvalidCredentials;
      case UIError.invalidField: return R.strings.msgInvalidField;
      case UIError.emailInUse: return R.strings.msgEmailInUse;
      default: return R.strings.msgUnexpected;
    }
  }

}