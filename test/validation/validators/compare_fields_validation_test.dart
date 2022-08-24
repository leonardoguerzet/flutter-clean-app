import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_app/presentation/protocols/protocols.dart';

import 'package:flutter_clean_app/validation/validators/validators.dart';


void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return error if values are not equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'other_value'};

    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'any_value'};

    expect(sut.validate(formData), null);
  });
}
