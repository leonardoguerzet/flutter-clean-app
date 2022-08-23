import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_app/presentation/protocols/protocols.dart';

import 'package:flutter_clean_app/validation/validators/validators.dart';


void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equal', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    expect(sut.validate('any_value'), null);
  });
}
