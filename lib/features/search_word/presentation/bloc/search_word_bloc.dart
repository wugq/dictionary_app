import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:dictionary/features/search_word/domain/usecases/search_word.dart';
import 'package:equatable/equatable.dart';

part 'search_word_event.dart';

part 'search_word_state.dart';

const String serverFailureMessage = 'Server Failure';

class SearchWordBloc extends Bloc<SearchWordEvent, SearchWordState> {
  final SearchWord searchWord;

  SearchWordBloc({
    required this.searchWord,
  }) : super(SearchWordInitial()) {
    on<SearchWordEvent>((event, emit) {
      if (event is SearchWordEventGetWord) {
        _search(event.text, emit);
      }
    });
  }

  void _search(String text, Emitter<SearchWordState> emit) async {
    emit(SearchWordStateLoading());
    final failedOrWord = await searchWord(SearchWordParam(word: text));
    failedOrWord.fold(
      (l) => emit(const SearchWordStateFailed(serverFailureMessage)),
      (r) => emit(SearchWordStateLoaded(r)),
    );
  }
}
