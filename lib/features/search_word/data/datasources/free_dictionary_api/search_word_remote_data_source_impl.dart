import 'dart:convert';

import 'package:dictionary/core/core.dart';
import 'package:dictionary/features/search_word/data/datasources/search_word_remote_data_source.dart';
import 'package:dictionary/features/search_word/data/models/free_dictionary_api/word_model.dart';
import 'package:http/http.dart' as http;

class SearchWordRemoteDataSourceImpl implements SearchWordRemoteDataSource {
  final http.Client client;
  final baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  SearchWordRemoteDataSourceImpl(this.client);

  @override
  Future<WordModel> search(String text) async {
    String url = baseUrl + text;
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List bodyJson = json.decode(response.body);
      return WordModel.fromJson(bodyJson[0]);
    } else {
      throw ServerException();
    }
  }
}
