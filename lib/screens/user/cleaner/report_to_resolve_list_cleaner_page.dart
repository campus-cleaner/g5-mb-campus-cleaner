import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/models/users_combo.dart';
import 'package:g5_mb_campus_cleaner/services/reports_service.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_detail_cleaner_page.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';

class ReportToResolveListCleanerPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  const ReportToResolveListCleanerPage(
      {super.key, required this.currentIndex, required this.userTypeIndex});
  @override
  State<ReportToResolveListCleanerPage> createState() =>
      _ReportToResolveListCleanerPageState();
}

class _ReportToResolveListCleanerPageState
    extends State<ReportToResolveListCleanerPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
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

  void _getPendientes() async {
    final service = ReportService();
    final response = await service.getReportsToAttend();
    setState(() {
      lista = response;
    });
  }

  void _getCleaners() async {
    final service = ReportService();
    final response = await service.getCombo();
    setState(() {
      usuariosCleaners = response;
    });
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
          children: [_buildList()],
        ),
      ))),
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
                    text: "Registro Pendiente: ${this.lista[index].reference}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReportToResolveDetailCleanerPage(
                                      userTypeIndex: widget.userTypeIndex,
                                      currentIndex: widget.currentIndex)),
                        );
                      },
                  )
                ],
              ),
            ),
          ),
          Text(this.lista[index].dateReport!),
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
}
