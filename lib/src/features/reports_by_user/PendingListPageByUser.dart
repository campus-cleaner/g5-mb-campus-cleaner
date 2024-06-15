import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/cleaner_person.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/navigation_bar/campus_app_navigation_bar.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/detail_report_pending.dart';
import 'package:g5_mb_campus_cleaner/src/login/login.dart';

class PendingListUserPage extends StatefulWidget {
  const PendingListUserPage({super.key});
  @override
  State<PendingListUserPage> createState() => _PendingListPage();
}

class _PendingListPage extends State<PendingListUserPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
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
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Warehouse B',
      status: 'In Progress',
      dateReport: '12/05/2024',
      selected: true,
    ),
    PendingReport(
      reference: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Store C',
      status: 'Completed',
      dateReport: '12/05/2024',
      selected: false,
    ),
    PendingReport(
      reference: 'Store C',
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
                      builder: (context) => const PendingListUserPage(),
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
      bottomNavigationBar: CampusNavigationBar.buildNavUser(context),
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
                    text: "Registro Pendiente ${index + 1}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailReportPendingPage()),
                        );
                      },
                  )
                ],
              ),
            ),
          ),
          Text(this.lista[index].status!),
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
