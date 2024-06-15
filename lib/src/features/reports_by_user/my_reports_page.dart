import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/cleaner_person.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/src/core/services/reports_service.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report.dart';
import 'package:g5_mb_campus_cleaner/src/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/src/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/src/widgets/custom_app_bar_widget.dart';

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
  List<PendingReport> lista = [];

  @override
  void initState() {
    super.initState();
    _getPendientes();
  }

  void _getPendientes() async {
    final service = ReportService();
    final response = await service.getMyReports();
    setState(() {
      lista = response;
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailReportPage()),
                        );
                      },
                  )
                ],
              ),
            ),
          ),
          TextUtil.buildBlackText(lista[index].status!)
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
