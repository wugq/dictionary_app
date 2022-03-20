import 'package:dictionary/features/search_word/data/datasources/free_dictionary_api/search_word_remote_data_source_impl.dart';
import 'package:dictionary/features/search_word/data/datasources/search_word_remote_data_source.dart';
import 'package:dictionary/features/search_word/data/repositories/search_word_repository_impl.dart';
import 'package:dictionary/features/search_word/domain/repositories/search_word_repository.dart';
import 'package:dictionary/features/search_word/domain/usecases/search_word.dart';
import 'package:dictionary/features/search_word/presentation/bloc/search_word_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => SearchWordBloc(searchWord: sl()));
  // usecase
  sl.registerLazySingleton(() => SearchWord(repository: sl()));
  // repository
  sl.registerLazySingleton<SearchWordRepository>(
      () => SearchWordRepositoryImpl(sl()));
  // data source
  sl.registerLazySingleton<SearchWordRemoteDataSource>(
      () => SearchWordRemoteDataSourceImpl(sl()));
  // external
  sl.registerLazySingleton(() => http.Client());
}
