import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/word.dart';
import '../bloc/search_word_bloc.dart';

class DictionaryHomePageWidget extends StatefulWidget {
  const DictionaryHomePageWidget({required Key key}) : super(key: key);

  @override
  _DictionaryHomePageWidgetState createState() =>
      _DictionaryHomePageWidgetState();
}

class _DictionaryHomePageWidgetState extends State<DictionaryHomePageWidget> {
  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final audioPlayer = AudioPlayer();

  List<Word> wordList = [];
  String wordText = "";
  late SearchWordBloc theBloc;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    theBloc = sl<SearchWordBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: _searchWidget(),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => theBloc,
        child: BlocListener<SearchWordBloc, SearchWordState>(
          listener: (context, state) {
            if (state is SearchWordStateLoaded) {
              setState(() {
                wordList = state.wordList;
                wordText = wordList.first.text;
              });
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  _thisWordWidget(wordText),
                  for (Word word in wordList)
                    _showPronunciationList(word.pronunciationList),
                  const SizedBox(height: 10),
                  for (Word word in wordList)
                    _showMeaningList(word.meaningList),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showPronunciationList(List<Pronunciation> list) {
    if (list.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var pronunciation in list) _pronunciationBtn(pronunciation),
        ],
      ),
    );
  }

  Widget _showMeaningList(List<Meaning> list) {
    if (list.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var meaning in list)
          for (var definition in meaning.definitionList)
            _definitionWidget(definition, meaning.partOfSpeech)
      ],
    );
  }

  Widget _definitionWidget(Definition definition, String partOfSpeech) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(partOfSpeech),
            Text(
              definition.definition,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF270303),
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in definition.exampleList)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Text(
                        "* $item",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pronunciationBtn(Pronunciation pronunciation) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
      child: pronunciation.audio.trim().isNotEmpty
          ? ElevatedButton.icon(
              onPressed: () {
                _playAudio(pronunciation.audio);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              label: Text(pronunciation.text),
              icon: const FaIcon(
                FontAwesomeIcons.volumeHigh,
                size: 12,
              ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(pronunciation.text),
            ),
    );
  }

  Widget _thisWordWidget(String title) {
    if (title == "") {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 48, fontFamily: 'Poppins'),
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                onChanged: (_) => EasyDebounce.debounce(
                  'textController',
                  const Duration(milliseconds: 2000),
                  () => setState(() {}),
                ),
                textInputAction: TextInputAction.search,
                controller: textController,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Find a Word',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF9E9E9E),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF9E9E9E),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: textController.text.isNotEmpty
                      ? InkWell(
                          onTap: () => setState(
                            () => textController.clear(),
                          ),
                          child: const Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )
                      : null,
                ),
                textAlign: TextAlign.start,
                onFieldSubmitted: (_) {
                  _callSearchWord();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callSearchWord() {
    String word = textController.value.text;
    if (word.isEmpty) {
      return;
    }
    theBloc.add(SearchWordEventGetWord(word));
  }

  void _playAudio(String url) async {
    String audioUrl = url.trim();
    if (audioUrl.isEmpty) {
      return;
    }
    await audioPlayer.setUrl(audioUrl);
    audioPlayer.play();
  }
}
