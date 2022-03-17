import 'package:dictionary/features/search_word/domain/entities/meaning.dart';
import 'package:dictionary/features/search_word/domain/entities/pronunciation.dart';
import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String text;
  final List<Pronunciation> pronunciationList;
  final List<Meaning> meaningList;

  const Word({
    required this.text,
    required this.pronunciationList,
    required this.meaningList,
  });

  @override
  List<Object?> get props => [text];
}
