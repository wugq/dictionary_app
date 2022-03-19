import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:dictionary/features/search_word/domain/usecases/search_word.dart';
import 'package:dictionary/features/search_word/presentation/bloc/search_word_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_word_bloc_test.mocks.dart';

@GenerateMocks([SearchWord])
void main() {
  late MockSearchWord mockSearchWord;
  late SearchWordBloc searchWordBloc;

  setUp(() {
    mockSearchWord = MockSearchWord();
    searchWordBloc = SearchWordBloc(searchWord: mockSearchWord);
  });

  const String tText = 'hello';
  const Word tWord = Word(
    text: tText,
    meaningList: [],
    pronunciationList: [],
  );

  blocTest<SearchWordBloc, SearchWordState>(
    "should return [Loading, Loaded] when data is gotten successfully",
    build: () {
      when(mockSearchWord(any)).thenAnswer((_) async => const Right(tWord));
      return searchWordBloc;
    },
    act: (bloc) {
      bloc.add(const SearchWordEventGetWord(tText));
    },
    expect: () => [
      SearchWordStateLoading(),
      const SearchWordStateLoaded(tWord),
    ],
  );

  blocTest<SearchWordBloc, SearchWordState>(
    "should return [Loading, Failed] when getting data is failed",
    build: () {
      when(mockSearchWord(any)).thenAnswer((_) async => Left(ServerFailure()));
      return searchWordBloc;
    },
    act: (bloc) {
      bloc.add(const SearchWordEventGetWord(tText));
    },
    expect: () => [
      SearchWordStateLoading(),
      const SearchWordStateFailed("message"),
    ],
  );
}
