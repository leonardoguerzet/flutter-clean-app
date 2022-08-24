import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 3),
    ]);
  });
}
