import 'package:dartz/dartz.dart';
import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';

abstract class SearchWordRepository {
  Future<Either<Failure, List<Word>>> search(String text);
}
