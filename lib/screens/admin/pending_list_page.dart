import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/models/users_combo.dart';
import 'package:g5_mb_campus_cleaner/services/reports_service.dart';
import 'package:g5_mb_campus_cleaner/screens/campus_app_navigation_bar.dart';
import 'package:g5_mb_campus_cleaner/screens/login.dart';
import 'package:g5_mb_campus_cleaner/utils/report_util.dart';

class PendingListPage extends StatefulWidget {
  const PendingListPage({super.key});
  @override
  State<PendingListPage> createState() => _PendingListPage();
}

class _PendingListPage extends State<PendingListPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  late Color myColor;
  late Size mediaSize;
  List<UserCombo> usuariosCleaners = [];
  List<PendingReport> lista = [];

  @override
  void initState() {
    super.initState();
    _getPendientes();
    _getCleaners();
  }

  void _getCleaners() async {
    final service = ReportService();
    final response = await service.getCombo();
    setState(() {
      usuariosCleaners = response;
    });
  }

  void _getPendientes() async {
    final service = ReportService();
    final response = await service.getReportsToAssign();
    setState(() {
      lista = response;
    });
  }

  Future<void> _saveResponsible(String data) async {
    final service = ReportService();
    final response = await service.assignResponsible(data);
  }

  @override
  Widget build(BuildContext context) {
    _fbKey.currentState?.fields['responsible']!
        .setValue(usuariosCleaners[0].id);
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportes Pendientes',
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              accountEmail: Text(
                "marco.mezaCancho@unmsm.edu.pe",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PendingListPage(),
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
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
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
            "Pendientes",
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

  Widget _buildBottom() {
    return SizedBox(
        height: 50,
        width: mediaSize.width,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
                onPressed:
                    lista.where((element) => element.selected == true).isEmpty
                        ? null
                        : () {
                            debugPrint(
                                "Enviando : ${lista.where((element) => element.selected == true)}");
                            _openBox();
                          },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 20,
                  backgroundColor: const Color.fromARGB(255, 31, 172, 90),
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text(
                  "Asignar",
                  style: TextStyle(color: Colors.white),
                ))));
  }

  Widget _buildList() {
    return SizedBox(
        width: mediaSize.width,
        height: 700,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pendientes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand'),
                        ),
                        SizedBox(
                            width: 130,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    lista = lista.map((e) {
                                      e.selected = true;
                                      return e;
                                    }).toList();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  elevation: 20,
                                  backgroundColor:
                                      const Color.fromARGB(255, 31, 172, 90),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                child: const Text(
                                  "Seleccionar",
                                  style: TextStyle(color: Colors.white),
                                )))
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
                _buildBottom(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildPendingElement(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(Icons.delete, size: 20),
                  ),
                  TextSpan(
                    text: "Registro ${index + 1}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ReportUtil.navigateToDetailReportPage(
                            context, lista.elementAt(index));
                      },
                  )
                ],
              ),
            ),
          ),
          Checkbox(
            value: lista.elementAt(index).selected,
            activeColor: const Color.fromARGB(255, 31, 172, 90),
            onChanged: (bool? newValue) {
              setState(() {
                lista.elementAt(index).selected = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPendings() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, position) {
          return _buildPendingElement(position);
        });
  }

  Future<void> _openBox() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: const Text(
                  'Asignar',
                  textAlign: TextAlign.center,
                ),
                content: FormBuilder(
                  key: _fbKey,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            FormBuilderDropdown(
                                name: "responsible",
                                focusColor: Colors.white,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]), //elevation: 5,
                                decoration: const InputDecoration(
                                  hintText: "Seleccionar Responsable",
                                  hintMaxLines: 1,
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFFF4240)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFFF4240)),
                                  ),
                                ),
                                items: usuariosCleaners
                                    .map((data) => DropdownMenuItem(
                                        value: data.id,
                                        child: Text(data.label!)))
                                    .toList()),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              child: const Text("Asignar"),
                              onPressed: () async {
                                if (_fbKey.currentState?.saveAndValidate() ??
                                    false) {
                                  if (this
                                              .lista
                                              .where((element) =>
                                                  element.selected == true)
                                              .length >
                                          0 &&
                                      _fbKey.currentState?.fields['responsible']
                                              ?.value !=
                                          null) {
                                    final params = jsonEncode(<String, dynamic>{
                                      'idResponsible': _fbKey.currentState
                                          ?.fields['responsible']?.value,
                                      'reportsToAssign': lista
                                          .where((element) =>
                                              element.selected == true)
                                          .map((e) => e.id)
                                          .toList()
                                    });
                                    await _saveResponsible(params);
                                    debugPrint(params);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PendingListPage()),
                                    );
                                  }
                                }
                              },
                            ),
                          ]))),
                )));
      },
    );
  }
}
