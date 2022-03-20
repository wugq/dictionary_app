import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  late Word theWord;
  late SearchWordBloc theBloc;

  @override
  void initState() {
    super.initState();
    theWord = const Word(text: "", pronunciationList: [], meaningList: []);
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
        title: const Text(
          'Dictionary',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => theBloc,
        child: BlocListener<SearchWordBloc, SearchWordState>(
          listener: (context, state) {
            if (state is SearchWordStateLoaded) {
              setState(() {
                theWord = state.word;
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
                  searchWidget(),
                  thisWordWidget(theWord.text),
                  showPronunciationList(theWord.pronunciationList),
                  showMeaningList(theWord.meaningList),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showPronunciationList(List<Pronunciation> list) {
    if (list.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var pronunciation in list) pronunciationBtn(pronunciation),
        ],
      ),
    );
  }

  Widget showMeaningList(List<Meaning> list) {
    if (list.isEmpty) {
      return Container();
    }
    return Column(
      children: [
        for (var meaning in list)
          for (var definition in meaning.definitionList)
            definitionWidget(definition)
      ],
    );
  }

  Widget definitionWidget(Definition definition) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "* $item",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
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

  Widget pronunciationBtn(Pronunciation pronunciation) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
      child: ElevatedButton.icon(
        onPressed: () {},
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
      ),
    );
  }

  Widget thisWordWidget(String title) {
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

  Widget searchWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
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
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF9E9E9E),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(50),
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
}
