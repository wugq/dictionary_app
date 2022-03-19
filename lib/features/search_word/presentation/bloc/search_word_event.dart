part of 'search_word_bloc.dart';

abstract class SearchWordEvent extends Equatable {
  const SearchWordEvent();
}

class SearchWordEventGetWord extends SearchWordEvent {
  final String text;

  const SearchWordEventGetWord(this.text);

  @override
  List<Object?> get props => [text];
}
