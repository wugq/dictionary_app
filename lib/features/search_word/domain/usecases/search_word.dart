import 'package:dartz/dartz.dart';
import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:dictionary/features/search_word/domain/repositories/search_word_repository.dart';
import 'package:equatable/equatable.dart';

class SearchWord extends UseCase<List<Word>, SearchWordParam> {
  final SearchWordRepository repository;

  SearchWord({required this.repository});

  @override
  Future<Either<Failure, List<Word>>> call(SearchWordParam params) async {
    return await repository.search(params.word);
  }
}

class SearchWordParam extends Equatable {
  final String word;

  const SearchWordParam({required this.word});

  @override
  List<Object?> get props => [word];
}
