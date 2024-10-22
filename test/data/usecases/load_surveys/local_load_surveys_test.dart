import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';

import 'package:flutter_clean_app/data/cache/cache.dart';
import 'package:flutter_clean_app/data/usecases/usecases.dart';

class CacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group('load', () {
    LocalLoadSurveys sut;
    CacheStorageSpy cacheStorage;
    List<Map> data;

    List<Map> mockValidData() => [
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2022-09-06T00:00:00Z',
            'didAnswer': 'false',
          },
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2021-02-03T00:00:00Z',
            'didAnswer': 'true',
          }
        ];

    PostExpectation mockFetchCall() => when(cacheStorage.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchCall().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call CacheStorage with correct key', () async {
      await sut.loadBySurvey();

      verify(cacheStorage.fetch('surveys')).called(1);
    });

    test('Should return a list of surveys on success', () async {
      final surveys = await sut.loadBySurvey();

      expect(surveys, {
        SurveyEntity(
            id: data[0]['id'],
            question: data[0]['question'],
            dateTime: DateTime.utc(2022, 9, 6),
            didAnswer: false),
        SurveyEntity(
            id: data[1]['id'],
            question: data[1]['question'],
            dateTime: DateTime.utc(2021, 2, 3),
            didAnswer: true),
      });
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      mockFetch([]);

      final future = sut.loadBySurvey();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is null', () async {
      mockFetch(null);

      final future = sut.loadBySurvey();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is invalid', () async {
      mockFetch([
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(10),
          'date': 'invalid date',
          'didAnswer': 'false',
        }
      ]);

      final future = sut.loadBySurvey();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      mockFetch([
        {
          'date': '2022-09-06T00:00:00Z',
          'didAnswer': 'false',
        }
      ]);

      final future = sut.loadBySurvey();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache throws', () async {
      mockFetchError();

      final future = sut.loadBySurvey();

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('validate', () {
    LocalLoadSurveys sut;
    CacheStorageSpy cacheStorage;
    List<Map> data;

    List<Map> mockValidData() => [
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2022-09-06T00:00:00Z',
            'didAnswer': 'false',
          },
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2021-02-03T00:00:00Z',
            'didAnswer': 'true',
          }
        ];

    PostExpectation mockFetchCall() => when(cacheStorage.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchCall().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call CacheStorage with correct key', () async {
      await sut.validate();

      verify(cacheStorage.fetch('surveys')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      mockFetch([
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(10),
          'date': 'invalid date',
          'didAnswer': 'false',
        }
      ]);

      await sut.validate();

      verify(cacheStorage.delete('surveys')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetch([
        {
          'date': '2021-02-03T00:00:00Z',
          'didAnswer': 'false',
        }
      ]);

      await sut.validate();

      verify(cacheStorage.delete('surveys')).called(1);
    });

    test('Should delete cache if it throws', () async {
      mockFetchError();

      await sut.validate();

      verify(cacheStorage.delete('surveys')).called(1);
    });
  });

  group('save', () {
    LocalLoadSurveys sut;
    CacheStorageSpy cacheStorage;
    List<SurveyEntity> surveys;

    PostExpectation mockSaveCall() =>
        when(cacheStorage.save(key: anyNamed('key'), value: anyNamed('value')));

    void mockSaveError() => mockSaveCall().thenThrow(Exception());

    List<SurveyEntity> mockSurveys() => [
          SurveyEntity(
              id: faker.guid.guid(),
              question: faker.randomGenerator.string(10),
              dateTime: DateTime.utc(2022, 9, 12),
              didAnswer: true),
          SurveyEntity(
              id: faker.guid.guid(),
              question: faker.randomGenerator.string(10),
              dateTime: DateTime.utc(2021, 3, 10),
              didAnswer: false),
        ];

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorage);
      surveys = mockSurveys();
    });

    test('Should call CacheStorage with correct values', () async {
      final list = [
        {
          'id': surveys[0].id,
          'question': surveys[0].question,
          'date': '2022-09-12T00:00:00.000Z',
          'didAnswer': 'true',
        },
        {
          'id': surveys[1].id,
          'question': surveys[1].question,
          'date': '2021-03-10T00:00:00.000Z',
          'didAnswer': 'false',
        },
      ];
      await sut.save(surveys);

      verify(cacheStorage.save(key: 'surveys', value: list)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      mockSaveError();

      final future = sut.save(surveys);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
