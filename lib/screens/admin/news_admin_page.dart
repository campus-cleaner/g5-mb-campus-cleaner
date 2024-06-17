import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
    return Card(
      child: Container(
        height: 180,
        width: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/new_fisi.png"))),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                IconButton(
                  onPressed: () {
                    _openBox();
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return SizedBox(
        width: mediaSize.width,
        height: 700,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Noticias",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand'),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: _buildPendings(),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  _openBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: Text(
                  'Asignar',
                  textAlign: TextAlign.center,
                ),
                content: FormBuilder(
                  key: _fbKey,
                  onChanged: () {
                    _fbKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  // this to show error when user is in some textField
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: FormBuilderFilePicker(
                                name: "images",
                                decoration:
                                    InputDecoration(labelText: "iMAGEN"),
                                maxFiles: 1,
                                validator: FormBuilderValidators.required(),
                                previewImages: true,
                                onChanged: (val) => print(val),
                                typeSelectors: [
                                  TypeSelector(
                                    type: FileType.image,
                                    selector: Row(
                                      children: <Widget>[
                                        Icon(Icons.add_circle),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text("Agregar imagen"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onFileLoading: (val) {
                                  print(val);
                                },
                              ),
                              width: 200.0,
                              height: 100.0,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: "url",
                              decoration: InputDecoration(labelText: "url"),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            ElevatedButton(
                              child: Text("Enviar"),
                              onPressed: () {
                                debugPrint(
                                    'validation correct ${_fbKey.currentState}');

                                if (_fbKey.currentState?.validate() ?? false) {
                                  final edificio = _fbKey
                                      .currentState?.fields['images']!.value;
                                  debugPrint('validation correct ${edificio}');
                                } else {
                                  debugPrint('validation failed');
                                }
                              },
                            ),
                          ])),
                )));
      },
    );
  }

  Widget _buildPendings() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, position) {
          return _buildElement();
        });
  }
}
