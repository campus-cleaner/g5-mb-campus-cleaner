import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
            child: _buildList(),
          ),
        ),
      ),
    );
  }

  Widget _buildElement() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/new_fisi.png"),
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
                      _openBox();
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

  Future<void> _openBox() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: TextUtil.buildBoldText("EDITAR NOTICIA", centered: true),
                content: FormBuilder(
                  key: _fbKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  onChanged: () {
                    _fbKey.currentState!.save();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300.0,
                        height: 72.0,
                        child: FormBuilderFilePicker(
                          name: "image",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Por favor selecciona una imagen.'),
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
                          maxFiles: 1,
                          previewImages: true,
                          typeSelectors: [
                            TypeSelector(
                              type: FileType.image,
                              selector: Row(
                                children: <Widget>[
                                  const Icon(Icons.add_circle),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextUtil.buildBlackText(
                                        "Seleccionar una imagen"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        name: "url",
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
                                  final image = _fbKey
                                      .currentState?.fields['image']!.value;
                                  final url =
                                      _fbKey.currentState?.fields['url']!.value;
                                  LoggerUtil.logInfo(image);
                                  LoggerUtil.logInfo(url);
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
    int itemCount = 3;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, position) {
        return Column(
          children: [
            _buildElement(),
            if (position != itemCount - 1) const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
