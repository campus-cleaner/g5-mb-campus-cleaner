import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';

class PendingListPage extends StatefulWidget {
  const PendingListPage({super.key});
  @override
  State<PendingListPage> createState() => _PendingListPage();
}

class _PendingListPage extends State<PendingListPage> {
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
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
      location: 'Office A',
      status: 'Pending',
      dateReport: '12/05/2024',
      selected: false,
    ),    PendingReport(
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
        'Lista de Pendientes',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
        backgroundColor: const Color.fromARGB(255, 31, 172, 90) ,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Positioned(top: 5, child: _buildTop()),
          Positioned(bottom: 100, child: _buildList()),
        ])
        )
    );

  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      height: 80,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
                onPressed:
                    lista.where((element) => element.selected == true).isEmpty
                        ? null
                        : () {
                            debugPrint(
                                "Enviando : ${lista.where((element) => element.selected == true)}");
                          },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 20,
                  backgroundColor: const Color.fromARGB(255, 31, 172, 90),
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text(
                  "Atendidos",
                  style: TextStyle(color: Colors.white),
                ))));
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
                  TextSpan(text: "Registro ${index + 1}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint('Label has been tapped. $index');
                      },)
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
}
