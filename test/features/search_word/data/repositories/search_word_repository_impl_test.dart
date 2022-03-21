import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/data/datasources/search_word_remote_data_source.dart';
import 'package:dictionary/features/search_word/data/models/free_dictionary_api/word_model.dart';
import 'package:dictionary/features/search_word/data/repositories/search_word_repository_impl.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_word_repository_impl_test.mocks.dart';

@GenerateMocks([SearchWordRemoteDataSource])
void main() {
  late MockSearchWordRemoteDataSource mockRemoteDataSource;
  late SearchWordRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockSearchWordRemoteDataSource();
    repository = SearchWordRepositoryImpl(mockRemoteDataSource);
  });

  const tText = "test";
  const tSimpleWordModel = WordModel(
    text: tText,
    pronunciationList: [],
    meaningList: [],
  );

  test('should return valid data when search is successful', () async {
    when(mockRemoteDataSource.search(any))
        .thenAnswer((_) async => [tSimpleWordModel]);

    final searchResult = await repository.search(tText);
    expect(true, searchResult.isRight());
    searchResult.fold((l) => null, (r) {
      expect(r.first.text, tText);
      expect(r.length, 1);
      expect(r.first, isA<Word>());
    });
  });

  test('should return server failure when search is unsuccessful', () async {
    when(mockRemoteDataSource.search(any)).thenThrow(ServerException());
    final result = await repository.search(tText);
    expect(result, equals(Left(ServerFailure())));
  });
}
