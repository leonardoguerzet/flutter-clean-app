import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/models/models.dart';
import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({@required this.fetchCacheStorage});

  Future<List<SurveyEntity>> load() async {
    final data = await fetchCacheStorage.fetch('surveys');
    return data
        .map<SurveyEntity>((json) => LocalSurveyModel.fromJson(json).toEntity())
        .toList();
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
}

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

void main() {
  LocalLoadSurveys sut;
  FetchCacheStorageSpy fetchCacheStorage;
  List<Map> data;

  void mockFetch(List<Map> list) {
    data = list;
    when(fetchCacheStorage.fetch(any)).thenAnswer((_) async => data);
  }

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
    mockFetch(mockValidData());
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('surveys')).called(1);
  });

  test('Should return a list of surveys on success', () async {
    final surveys = await sut.load();

    expect(
      surveys, {
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
}
