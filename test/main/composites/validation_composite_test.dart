import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/main/composites/composites.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  mockValidation1(ValidationError error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  mockValidation2(ValidationError error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  mockValidation3(ValidationError error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);
    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);
    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    final error = sut.validate(field: 'any_field', input: {'any_field': 'any_value'});

    expect(error, null);
  });

  test('Should return the first error', () {
    mockValidation1(ValidationError.requiredField);
    mockValidation2(ValidationError.requiredField);
    mockValidation3(ValidationError.invalidField);

    final error = sut.validate(field: 'any_field', input: {'any_field': 'any_value'});

    expect(error, ValidationError.requiredField);
  });
}