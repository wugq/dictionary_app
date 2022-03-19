import 'dart:io';

import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/data/datasources/free_dictionary_api/search_word_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'search_word_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late SearchWordRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = SearchWordRemoteDataSourceImpl(mockHttpClient);
  });

  void setupMockHttpClientSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
          fixture('free_dictionary_api/hello.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ));
  }

  void setupMockHttpClientSuccess404() {
    when(mockHttpClient.get(any)).thenAnswer((_) async =>
        http.Response(fixture('free_dictionary_api/404.json'), 404));
  }

  test('should return valid model when http request is succeed', () async {
    setupMockHttpClientSuccess200();
    final result = await dataSource.search("test");
    expect(result.text, "hello");
    expect(result.pronunciationList.length, 3);
    expect(result.meaningList.length, 3);
  });

  test('should throw serverException when http request is failed', () async {
    setupMockHttpClientSuccess404();
    final call = dataSource.search;
    expect(() => call(""), throwsA(const TypeMatcher<ServerException>()));
  });
}
