import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/cleaner_person.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/navigation_bar/campus_app_navigation_bar.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/PendingListPageByResponsible.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/detail_report_pending.dart';
import 'package:g5_mb_campus_cleaner/src/login/login_page.dart';

class NewsAdminPage extends StatefulWidget {
  const NewsAdminPage({super.key});
  @override
  State<NewsAdminPage> createState() => _NewsAdminPage();
}

class _NewsAdminPage extends State<NewsAdminPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  late Color myColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = Theme
        .of(context)
        .primaryColor;
    mediaSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noticias Admin',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 172, 90),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 31, 172, 90),
              ),
              accountName: Text(
                "Usuario XYZ",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              accountEmail: Text(
                "marco.mezaCancho@unmsm.edu.pe",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/147/147142.png"),
              ), //For Image Asset
            ),
            ExpansionTile(
              leading: const Icon(Icons.flag),
              title: const Text("Incidencias"),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text('Historial de Incidencias'),
                  onTap: () =>
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (
                              context) => const PendingListResponsiblePage(),
                        ),
                      ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: CampusNavigationBar.buildNav(context),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Positioned(top: 30, child: _buildTop()),
          Positioned(bottom: 20, child: _buildList()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      height: 70,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Noticias",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                fontSize: 40,
                letterSpacing: 2),
          ),
        ],
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
                image: AssetImage("assets/images/new_fisi.png"))
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                IconButton(
                  onPressed: () {},
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
                      child: Form(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FormBuilderTextField(
                                    name: "imagen",
                                    validator: FormBuilderValidators.required(),
                                    decoration: const InputDecoration(
                                      hintText: "Ingresar imagen",
                                      hintMaxLines: 1,
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFFF4240)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFFF4240)),
                                      ),)
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                  child: Text("Asignar"),
                                  onPressed: () {
                                    debugPrint('validation correct ${_fbKey
                                        .currentState}');

                                    if (_fbKey.currentState?.validate() ??
                                        false) {
                                      final edificio =
                                          _fbKey.currentState
                                              ?.fields['responsible']!.value;
                                      debugPrint(
                                          'validation correct ${edificio}');
                                    } else {
                                      debugPrint('validation failed');
                                    }
                                  },
                                ),
                              ]))),
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