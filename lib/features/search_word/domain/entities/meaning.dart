import 'package:dictionary/features/search_word/domain/entities/definition.dart';
import 'package:equatable/equatable.dart';

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
