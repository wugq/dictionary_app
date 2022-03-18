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

class Pronunciation extends Equatable {
  final String audio;
  final String text;

  const Pronunciation({
    required this.audio,
    required this.text,
  });

  @override
  List<Object?> get props => [audio, text];
}

class Meaning extends Equatable {
  final String partOfSpeech;
  final List<Definition> definitionList;
  final List<String> synonymList;
  final List<String> antonymList;

  const Meaning({
    required this.partOfSpeech,
    required this.definitionList,
    required this.synonymList,
    required this.antonymList,
  });

  @override
  List<Object?> get props => [partOfSpeech];
}

class Definition extends Equatable {
  final String definition;
  final List<String> synonymList;
  final List<String> antonymList;
  final List<String> exampleList;

  const Definition({
    required this.definition,
    required this.synonymList,
    required this.antonymList,
    required this.exampleList,
  });

  @override
  List<Object?> get props => [definition];
}
