part of 'search_word_bloc.dart';

abstract class SearchWordState extends Equatable {
  const SearchWordState();
}

class SearchWordInitial extends SearchWordState {
  @override
  List<Object> get props => [];
}

class SearchWordStateLoading extends SearchWordState {
  @override
  List<Object?> get props => [];
}

class SearchWordStateLoaded extends SearchWordState {
  final List<Word> wordList;

  const SearchWordStateLoaded(this.wordList);

  @override
  List<Object?> get props => [wordList];
}

class SearchWordStateFailed extends SearchWordState {
  final String message;

  const SearchWordStateFailed(this.message);

  @override
  List<Object?> get props => [message];
}
