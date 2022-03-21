import 'package:dartz/dartz.dart';
import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/data/datasources/search_word_remote_data_source.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:dictionary/features/search_word/domain/repositories/search_word_repository.dart';

class SearchWordRepositoryImpl implements SearchWordRepository {
  final SearchWordRemoteDataSource dataSource;

  SearchWordRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Word>>> search(String text) async {
    try {
      final wordList = await dataSource.search(text);
      return Right(wordList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
