import 'package:dictionary/features/search_word/domain/entities/word.dart';

class WordModel extends Word {
  const WordModel({
    required String text,
    required List<Pronunciation> pronunciationList,
    required List<Meaning> meaningList,
  }) : super(
            text: text,
            pronunciationList: pronunciationList,
            meaningList: meaningList);

  factory WordModel.fromJson(Map<String, dynamic> json) {
    String text = json['word'];
    List<Pronunciation> pronunciationList = [];
    List<Meaning> meaningList = [];
    if (json["phonetics"] != null) {
      pronunciationList = List<Pronunciation>.from(
          json["phonetics"].map((x) => PronunciationModel.fromJson(x)));
    }
    if (json['meanings'] != null) {
      meaningList = List<Meaning>.from(
          json["meanings"].map((x) => MeaningModel.fromJson(x)));
    }
    return WordModel(
      text: text,
      pronunciationList: pronunciationList,
      meaningList: meaningList,
    );
  }
}

class PronunciationModel extends Pronunciation {
  const PronunciationModel({
    required String audio,
    required String text,
  }) : super(audio: audio, text: text);

  factory PronunciationModel.fromJson(Map<String, dynamic> json) =>
      PronunciationModel(
        audio: json["audio"] ?? "",
        text: json["text"] ?? "",
      );
}

class MeaningModel extends Meaning {
  const MeaningModel({
    required String partOfSpeech,
    required List<Definition> definitionList,
    required List<String> synonymList,
    required List<String> antonymList,
  }) : super(
            partOfSpeech: partOfSpeech,
            definitionList: definitionList,
            synonymList: synonymList,
            antonymList: antonymList);

  factory MeaningModel.fromJson(Map<String, dynamic> json) => MeaningModel(
        partOfSpeech: json["partOfSpeech"],
        definitionList: List<Definition>.from(
            json["definitions"].map((x) => DefinitionModel.fromJson(x))),
        synonymList: List<String>.from(json["synonyms"].map((x) => x)),
        antonymList: List<String>.from(json["antonyms"].map((x) => x)),
      );
}

class DefinitionModel extends Definition {
  const DefinitionModel({
    required String definition,
    required List<String> synonymList,
    required List<String> antonymList,
    required List<String> exampleList,
  }) : super(
            definition: definition,
            synonymList: synonymList,
            antonymList: antonymList,
            exampleList: exampleList);

  factory DefinitionModel.fromJson(Map<String, dynamic> json) =>
      DefinitionModel(
        definition: json["definition"],
        synonymList: List<String>.from(json["synonyms"].map((x) => x)),
        antonymList: List<String>.from(json["antonyms"].map((x) => x)),
        exampleList: json["example"] == null ? [] : [json["example"]],
      );
}
