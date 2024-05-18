import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/navigation_bar/campus_app_navigation_bar.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/PendingListPageByResponsible.dart';

class DetailReportPendingPage extends StatefulWidget {
  const DetailReportPendingPage({super.key});
  @override
  State<DetailReportPendingPage> createState() => _DetailReportPendingPage();
}

class _DetailReportPendingPage extends State<DetailReportPendingPage> {
  late Color myColor;
  late Size mediaSize;
  List<PendingReport> lista = [
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Warehouse B',
      status: 'In Progress',
      dateReport: '12/05/2024',
      selected: true,
    ),
    PendingReport(
      location: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      location: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    )
  ];
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de Reporte',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 172, 90),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      //bottomNavigationBar: CampusNavigationBar.buildNav(context),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Positioned(top: 30, child: _buildTop()),
          Positioned(bottom: 20, child: _buildDetailReport()),
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
            "Reporte",
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

  Widget _builtDetailInfo() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ubicacion"),
                        Text(
                          "data",
                          style: TextStyle(),
                        )
                      ]),
                ),
                Container(
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("Referencia"), Text("data")]),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [Text("Comentario")],
            )
          ],
        ));
  }

  Widget _buildBottom() {
    return SizedBox(
        height: 50,
        width: mediaSize.width,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
                onPressed:
                    lista.where((element) => element.selected == true).isEmpty
                        ? null
                        : () {
                            debugPrint(
                                "Enviando : ${lista.where((element) => element.selected == true)}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PendingListResponsiblePage()),
                            );
                          },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 20,
                  backgroundColor: const Color.fromARGB(255, 31, 172, 90),
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text(
                  "Resuelto",
                  style: TextStyle(color: Colors.white),
                ))));
  }

  Widget _buildDetailReport() {
    return SizedBox(
        width: mediaSize.width,
        height: 700,
        child: Padding(
          padding: EdgeInsets.all(1.0),
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
                        horizontal: 20, vertical: 30),
                    decoration: DottedDecoration(
                        shape: Shape.line,
                        linePosition: LinePosition.bottom,
                        color: Colors.black),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/github.png"),
                        ),
                        Container(
                            width: 130,
                            height: 40,
                            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: const Column(
                              children: [Text("Usuario"), Text("prueba")],
                            ))
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                _imageReport(),
                _builtDetailInfo(),
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

  Widget _imageReport() {
    return Container(
      height: 380,
      child: Container(
        child: Column(
          children: [
            const Column(children: [Text("Foto"), Text("10:00 am")]),
            Container(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10),
              decoration: DottedDecoration(
                  shape: Shape.line,
                  linePosition: LinePosition.bottom,
                  color: Colors.black),
              child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        image: DecorationImage(
                            image: AssetImage("assets/images/garbage.png"),
                            fit: BoxFit.fitWidth)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
