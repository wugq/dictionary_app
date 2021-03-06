import 'package:dictionary/features/search_word/data/models/free_dictionary_api/word_model.dart';

abstract class SearchWordRemoteDataSource {
  Future<List<WordModel>> search(String text);
}
