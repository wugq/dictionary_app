import 'package:dartz/dartz.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:dictionary/features/search_word/domain/repositories/search_word_repository.dart';
import 'package:dictionary/features/search_word/domain/usecases/search_word.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'search_word_test.mocks.dart';

@GenerateMocks([SearchWordRepository])
void main() {
  late SearchWord searchWord;
  late MockSearchWordRepository mockRepository;

  setUp(() {
    mockRepository = MockSearchWordRepository();
    searchWord = SearchWord(repository: mockRepository);
  });

  const String tText = 'hello';
  const Word tWord = Word(
    text: tText,
    meaningList: [],
    pronunciationList: [],
  );

  test("should get word from repository", () async {
    when(mockRepository.search(any))
        .thenAnswer((_) async => const Right([tWord]));

    final result = await searchWord(const SearchWordParam(word: tText));
    expect(result, const Right([tWord]));

    verify(mockRepository.search(tText));
    verifyNoMoreInteractions(mockRepository);
  });
}
