import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_app/presentation/protocols/protocols.dart';

import 'package:flutter_clean_app/validation/validators/validators.dart';


void main() {
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    expect(sut.validate(faker.randomGenerator.string(4, min: 1)), ValidationError.invalidField);
  });

  test('Should return null if value is equal than min size', () {
    expect(sut.validate(faker.randomGenerator.string(5, min: 5)), null);
  });

  test('Should return null if value is bigger than min size', () {
    expect(sut.validate(faker.randomGenerator.string(10, min: 6)), null);
  });
}
