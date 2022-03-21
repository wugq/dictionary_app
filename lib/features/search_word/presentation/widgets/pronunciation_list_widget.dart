import 'package:dictionary/features/search_word/domain/entities/word.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

class PronunciationListWidget extends StatefulWidget {
  final AudioPlayer playerInstance;
  final List<Word> wordList;

  const PronunciationListWidget({
    Key? key,
    required this.playerInstance,
    required this.wordList,
  }) : super(key: key);

  @override
  State<PronunciationListWidget> createState() =>
      _PronunciationListWidgetState();
}

class _PronunciationListWidgetState extends State<PronunciationListWidget> {
  late List<Pronunciation> pronunciationList;

  @override
  void initState() {
    pronunciationList = makeList(widget.wordList);
    super.initState();
  }

  @override
  void didUpdateWidget(PronunciationListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    pronunciationList = makeList(widget.wordList);
  }

  List<Pronunciation> makeList(List<Word> wordList) {
    List<Pronunciation> newList = [];
    for (Word word in wordList) {
      newList.addAll(word.pronunciationList);
    }
    return newList.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    if (pronunciationList.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pronunciationList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: PronunciationButton(
              pronunciation: pronunciationList[index],
              playerInstance: widget.playerInstance,
            ),
          );
        },
      ),
    );
  }
}

class PronunciationButton extends StatelessWidget {
  final Pronunciation pronunciation;
  final AudioPlayer playerInstance;

  PronunciationButton({
    Key? key,
    required this.pronunciation,
    required this.playerInstance,
  }) : super(key: key);

  final buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
  );

  void _playAudio(String url) async {
    String audioUrl = url.trim();
    if (audioUrl.isEmpty) {
      return;
    }
    await playerInstance.setUrl(audioUrl);
    playerInstance.play();
  }

  @override
  Widget build(BuildContext context) {
    if (pronunciation.audio.trim().isNotEmpty) {
      return ElevatedButton.icon(
        onPressed: () {
          _playAudio(pronunciation.audio);
        },
        style: buttonStyle,
        label: Text(pronunciation.text),
        icon: const FaIcon(FontAwesomeIcons.volumeHigh, size: 12),
      );
    } else {
      return ElevatedButton(
        onPressed: () {},
        style: buttonStyle,
        child: Text(pronunciation.text),
      );
    }
  }
}
