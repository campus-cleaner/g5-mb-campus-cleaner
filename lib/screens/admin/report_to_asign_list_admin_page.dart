import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/models/users_combo.dart';
import 'package:g5_mb_campus_cleaner/services/reports_service.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/report_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';

class ReportToAsignListAdminPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  const ReportToAsignListAdminPage(
      {super.key, required this.currentIndex, required this.userTypeIndex});
  @override
  State<ReportToAsignListAdminPage> createState() =>
      _ReportToAsignListAdminPageState();
}

class _ReportToAsignListAdminPageState
    extends State<ReportToAsignListAdminPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  late Color myColor;
  late Size mediaSize;
  late bool isSending;
  List<UserCombo> usuariosCleaners = [];
  List<PendingReport> lista = [];

  @override
  void initState() {
    super.initState();
    _getPendientes();
    _getCleaners();
    isSending = false;
  }

  void _getCleaners() async {
    final service = ReportService();
    final response = await service.getCombo();
    if (mounted) {
      setState(() {
        usuariosCleaners = response;
      });
    }
  }

  void _getPendientes() async {
    final service = ReportService();
    final response = await service.getReportsToAssign();
    if (mounted) {
      setState(() {
        lista = response;
      });
    }
  }

  Future<void> _saveResponsible(String data) async {
    final service = ReportService();
    await service.assignResponsible(data);
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Mis reportes", automaticallyImplyLeading: false),
      bottomNavigationBar: AppNavigationBarWidget(
          currentIndex: widget.currentIndex,
          userTypeIndex: widget.userTypeIndex),
      body: Scrollbar(
          child: SingleChildScrollView(
              child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [_buildList(), _buildBottom()],
        ),
      ))),
    );
  }

  Widget _buildList() {
    return SizedBox(
        width: mediaSize.width,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: SizedBox(
                    height: 630,
                    child: Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextUtil.buildBoldText("Pendientes"),
                                    IntrinsicWidth(
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
                                          backgroundColor: const Color.fromARGB(
                                              255, 31, 172, 90),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                        ),
                                        child: TextUtil.buildBoldText(
                                          "Seleccionar todo",
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: _buildPendings(),
                                ),
                              ],
                            )))))));
  }

  Widget _buildBottom() {
    return SizedBox(
        width: mediaSize.width,
        child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
            child: ElevatedButton(
                onPressed:
                    lista.where((element) => element.selected == true).isEmpty
                        ? null
                        : () {
                            debugPrint(
                                "Enviando : ${lista.where((element) => element.selected == true)}");
                            _openBox();
                          },
                style: ButtonUtil.buildGreenButton(),
                child:
                    TextUtil.buildBoldText("ASIGNAR", color: Colors.white))));
  }

  Widget _buildPendingElement(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                    text: "Reporte ${index + 1}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontSize: 15),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ReportUtil.navigateToReportDetailPage(
                            context: context,
                            report: lista.elementAt(index),
                            userTypeIndex: widget.userTypeIndex,
                            currentIndex: widget.currentIndex);
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
                title: TextUtil.buildBoldText("ASIGNAR", centered: true),
                content: FormBuilder(
                  key: _fbKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormBuilderDropdown(
                        name: "responsible",
                        focusColor: Colors.white,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText:
                                  'Por favor selecciona un responsable.'),
                        ]),
                        decoration: const InputDecoration(
                          hintText: "Seleccionar Responsable",
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
                        items: usuariosCleaners
                            .map((data) => DropdownMenuItem(
                                value: data.id,
                                child: TextUtil.buildBlackText(data.label!)))
                            .toList(),
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
                                  if (lista
                                          .where((element) =>
                                              element.selected == true)
                                          .isNotEmpty &&
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
                                    setState(() {
                                      isSending = false;
                                    });
                                    if (!mounted) return;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReportToAsignListAdminPage(
                                                  userTypeIndex:
                                                      widget.userTypeIndex,
                                                  currentIndex:
                                                      widget.currentIndex)),
                                    );
                                  }
                                }
                              },
                        style: ButtonUtil.buildGreenButton(),
                        child: TextUtil.buildBoldText("ASIGNAR",
                            color: Colors.white),
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}
