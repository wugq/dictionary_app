import 'dart:convert';

import 'package:dictionary/features/search_word/data/models/free_dictionary_api/word_model.dart';
import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tText = "test";
  const tSimpleWordModel = WordModel(
    text: tText,
    pronunciationList: [],
    meaningList: [],
  );

  test('should be a subclass of Word entity', () {
    expect(tSimpleWordModel, isA<Word>());
  });

  group('fromJson', () {
    test('should return a valid model from a simple Json', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('free_dictionary_api/simple_word.json'));

      final result = WordModel.fromJson(jsonMap);
      expect(result, tSimpleWordModel);
    });

    group('test pronunciation', () {
      const tText = "test";
      const tAudio =
          "https://api.dictionaryapi.dev/media/pronunciations/en/hello-au.mp3";
      const tPronunciation1 = PronunciationModel(audio: tAudio, text: tText);
      const tPronunciation2 = PronunciationModel(audio: "", text: tText);
      const tPronunciation3 = PronunciationModel(audio: tAudio, text: "");

      test('should handle text only json', () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('free_dictionary_api/pronunciation_2.json'));
        final result = PronunciationModel.fromJson(jsonMap);
        expect(result, tPronunciation2);
      });
      test('should handle audio only json', () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('free_dictionary_api/pronunciation_3.json'));
        final result = PronunciationModel.fromJson(jsonMap);
        expect(result, tPronunciation3);
      });
      test('should handle full json', () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('free_dictionary_api/pronunciation_1.json'));
        final result = PronunciationModel.fromJson(jsonMap);
        expect(result, tPronunciation1);
        expect(result, isA<Pronunciation>());
      });
    });

    group('test definition', () {
      const tText = "An expression of puzzlement or discovery.";
      const tExample = "Hello! What’s going on here?";
      const tDefinitionModel = DefinitionModel(
        definition: tText,
        synonymList: [],
        antonymList: [],
        exampleList: [tExample],
      );

      test('should return a valid DefinitionModel', () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('free_dictionary_api/definition.json'));
        final result = DefinitionModel.fromJson(jsonMap);
        expect(result, tDefinitionModel);
        expect(result, isA<Definition>());
      });
    });

    group('test meaning', () {
      const String tPartOfSpeech = "noun";
      const String tDefinition = "greeting";
      const String tSynonym = "greeting";
      const DefinitionModel tDefinitionModel = DefinitionModel(
        antonymList: [],
        definition: tDefinition,
        exampleList: [],
        synonymList: [],
      );
      const MeaningModel tMeaningModel = MeaningModel(
        partOfSpeech: tPartOfSpeech,
        definitionList: [tDefinitionModel],
        synonymList: [tSynonym],
        antonymList: [],
      );
      test('should return a valid MeaningModel', () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('free_dictionary_api/meaning.json'));
        final result = MeaningModel.fromJson(jsonMap);
        expect(result, tMeaningModel);
        expect(result, isA<Meaning>());
      });
    });

    test(
      'should return a valid model from a simple Json with pronunciation',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
            fixture('free_dictionary_api/word_with_pronunciation_only.json'));
        final result = WordModel.fromJson(jsonMap);
        expect(result.text, tSimpleWordModel.text);
        expect(result.pronunciationList.length, 3);
      },
    );

    test('should return a valid WordModel from a full word json', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('free_dictionary_api/full_word.json'));
      final result = WordModel.fromJson(jsonMap);
      expect(result.text, "hello");
      expect(result.pronunciationList.length, 3);
      expect(result.meaningList.length, 3);
    });
  });
}
