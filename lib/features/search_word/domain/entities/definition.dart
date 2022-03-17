import 'package:equatable/equatable.dart';

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
