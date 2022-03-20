import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              searchWidget(),
              thisWordWidget("hi"),
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    pronunciationBtn("hi"),
                  ],
                ),
              ),
              Column(
                children: [
                  meaningWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget meaningWidget() {
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
              'Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World',
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
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '* Hello WorldHello ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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

  Widget pronunciationBtn(String text) {
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
        label: Text(text),
        icon: const FaIcon(
          FontAwesomeIcons.volumeHigh,
          size: 12,
        ),
      ),
    );
  }

  Widget thisWordWidget(String title) {
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
                // style:
                //     FlutterFlowTheme.of(context).bodyText1.override(
                //           fontFamily: 'Poppins',
                //           color: Color(0xFF091249),
                //         ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
