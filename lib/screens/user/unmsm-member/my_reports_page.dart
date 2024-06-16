import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/models/cleaner_person.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/services/reports_service.dart';
import 'package:g5_mb_campus_cleaner/utils/format_text_util.dart';
import 'package:g5_mb_campus_cleaner/utils/report_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});
  @override
  State<MyReportsPage> createState() => _MyReportsPage();
}

class _MyReportsPage extends State<MyReportsPage> {
  late Color myColor;
  late Size mediaSize;
  List<CleanerPersonal> dummyData = [
    CleanerPersonal(id: 1, label: 'Alice'),
    CleanerPersonal(id: 2, label: 'Bob'),
    CleanerPersonal(id: 3, label: 'Charlie'),
    CleanerPersonal(id: 4, label: 'David'),
    CleanerPersonal(id: 5, label: 'Eve'),
  ];
  List<PendingReport> lista = [
    PendingReport(
        id: 0,
        reference: "Huaca",
        imageRoute: "./.",
        latitude: 5.8,
        longitude: 6.0,
        comment: "dffs",
        userRegister: "Nicole Morales",
        idUserRegister: 1,
        status: "En progreso",
        dateReport: FormatTextUtil.formatDateTime(DateTime.now()))
  ];

  @override
  void initState() {
    super.initState();
    _getPendientes();
  }

  void _getPendientes() async {
    final service = ReportService();
    final response = await service.getMyReports();
    setState(() {
      //lista = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Mis reportes", automaticallyImplyLeading: false),
      bottomNavigationBar:
          const AppNavigationBarWidget(currentIndex: 0, userTypeIndex: 0),
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
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: SizedBox(
                    height: 700,
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
                                    TextUtil.buildBoldText("Estado")
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
                        ReportUtil.navigateToDetailReportPage(
                            context, lista.elementAt(index));
                      },
                  )
                ],
              ),
            ),
          ),
          TextUtil.buildBlackText(lista.elementAt(index).status!)
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
