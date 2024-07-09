import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/models/new.dart';
import 'package:g5_mb_campus_cleaner/services/file_service.dart';
import 'package:g5_mb_campus_cleaner/services/news_service.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';

class NewsAdminPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  const NewsAdminPage(
      {super.key, required this.currentIndex, required this.userTypeIndex});
  @override
  State<NewsAdminPage> createState() => _NewsAdminPageState();
}

class _NewsAdminPageState extends State<NewsAdminPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  late Color myColor;
  late Size mediaSize;
  bool isSending = false;
  List<New> lista = [];

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Noticias", automaticallyImplyLeading: false),
      bottomNavigationBar: AppNavigationBarWidget(
          currentIndex: widget.currentIndex,
          userTypeIndex: widget.userTypeIndex),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage("assets/images/bg_2.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(children: [_buildList(), _buildBottom()]),
          ),
        ),
      ),
    );
  }

  Widget _buildElement(int position) {
    String url = FileService.getUrlImageFromServer(lista[position].urlImagen);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    color: Colors.black,
                    onPressed: () {
                      isSending = false;
                      _openBox(lista[position].id, 'EDITAR NOTICIA');
                    },
                    icon: const Icon(Icons.edit_square),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      width: mediaSize.width,
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: SizedBox(
              height: 600,
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildNews(),
                ),
              ))),
    );
  }

  @override
  void initState() {
    super.initState();
    _getNews();
    isSending = false;
  }

  Widget _buildBottom() {
    return SizedBox(
        width: mediaSize.width,
        child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
            child: ElevatedButton(
                onPressed: () {
                  isSending = false;
                  _openBox(null, 'REGISTRAR NOTICIA');
                },
                style: ButtonUtil.buildGreenButton(),
                child: TextUtil.buildBoldText("NUEVO", color: Colors.white))));
  }

  void _getNews() async {
    final service = NewsService();
    final response = await service.getNews();
    if (mounted) {
      setState(() {
        isSending = false;
        lista = response;
      });
    }
  }

  Future<void> _openBox(int? id, String titleModal) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final service = NewsService();
        return SafeArea(
            child: AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: TextUtil.buildBoldText(titleModal, centered: true),
                content: FormBuilder(
                  key: _fbKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  onChanged: () {
                    _fbKey.currentState!.save();
                  },
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: "title",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText:
                                  'Por favor ingrese el título de la noticia.'),
                        ]),
                        decoration: const InputDecoration(
                          hintText: "Ingresar título",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontSize: 15),
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 31, 172, 90),
                                width: 2.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF4240), width: 2.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF4240), width: 2.0),
                          ),
                        ),
                      ),
                      FormBuilderTextField(
                        name: "urlExternal",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText:
                                  'Por favor ingrese la URL de la noticia.'),
                        ]),
                        decoration: const InputDecoration(
                          hintText: "Ingresar la URL",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontSize: 15),
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 31, 172, 90),
                                width: 2.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF4240), width: 2.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFFF4240), width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 300.0,
                          height: 86.0,
                          child: ListView(
                            children: [
                              FormBuilderFilePicker(
                                name: "image",
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText:
                                          'Por favor selecciona una imagen.'),
                                ]),
                                decoration: const InputDecoration(
                                  hintText: "Seleccionar una imagen",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontSize: 15),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12.0),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 31, 172, 90),
                                        width: 2.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFFF4240), width: 2.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFFF4240), width: 2.0),
                                  ),
                                ),
                                maxFiles: 1,
                                previewImages: true,
                                typeSelectors: [
                                  TypeSelector(
                                    type: FileType.image,
                                    selector: Row(
                                      children: <Widget>[
                                        const Icon(Icons.add_circle),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: TextUtil.buildBlackText(
                                              "Seleccionar una imagen"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isSending
                            ? null
                            : () async {
                                setState(() {
                                  isSending = true;
                                });
                                if (_fbKey.currentState?.saveAndValidate() ??
                                    false) {
                                  final List<PlatformFile> image = _fbKey
                                      .currentState?.fields['image']!.value;
                                  final title = _fbKey
                                      .currentState?.fields['title']!.value;
                                  final urlExternal = _fbKey.currentState
                                      ?.fields['urlExternal']!.value;
                                  LoggerUtil.logInfo(image[0].path ?? '');
                                  File file = File(image[0].path!);
                                  await service.saveNew(
                                      id, title, urlExternal, file);
                                  setState(() {
                                    isSending = false;
                                  });
                                  if (!mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsAdminPage(
                                            userTypeIndex: widget.userTypeIndex,
                                            currentIndex: widget.currentIndex)),
                                  );
                                }
                              },
                        style: ButtonUtil.buildGreenButton(),
                        child: TextUtil.buildBoldText("GUARDAR",
                            color: Colors.white),
                      ),
                    ],
                  ),
                )));
      },
    );
  }

  Widget _buildNews() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, position) {
          return Column(
            children: [
              _buildElement(position),
              if (position != lista.length - 1) const SizedBox(height: 20),
            ],
          );
        });
  }
}
