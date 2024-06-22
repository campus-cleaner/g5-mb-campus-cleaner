import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_list_cleaner_page.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/report_card_widget.dart';

class ReportToResolveDetailCleanerPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  final String reference;
  final String comment;
  final String dateTime;
  final File image;
  final double latitude;
  final double longitude;
  const ReportToResolveDetailCleanerPage(
      {super.key,
      required this.currentIndex,
      required this.userTypeIndex,
      required this.reference,
      required this.comment,
      required this.dateTime,
      required this.image,
      required this.latitude,
      required this.longitude});
  @override
  State<ReportToResolveDetailCleanerPage> createState() =>
      _ReportToResolveDetailCleanerPageState();
}

class _ReportToResolveDetailCleanerPageState
    extends State<ReportToResolveDetailCleanerPage> {
  late Color myColor;
  late Size mediaSize;
  List<PendingReport> lista = [];
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Detalle del reporte", automaticallyImplyLeading: true),
      bottomNavigationBar: AppNavigationBarWidget(
          userTypeIndex: widget.userTypeIndex,
          currentIndex: widget.currentIndex),
      body: Scrollbar(
          child: SingleChildScrollView(
              child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
        ),
        child: _buildContent(),
      ))),
    );
  }

  Widget _buildBottom() {
    return ElevatedButton(
        onPressed: () {
          lista.where((element) => element.selected == true).isEmpty
              ? null
              : () {
                  debugPrint(
                      "Enviando : ${lista.where((element) => element.selected == true)}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportToResolveListCleanerPage(
                            userTypeIndex: widget.userTypeIndex,
                            currentIndex: widget.currentIndex)),
                  );
                };
        },
        style: ButtonUtil.buildGreenButton(),
        child: TextUtil.buildBoldText("RESUELTO", color: Colors.white));
  }

  Widget _buildContent() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [_buildTop(), const SizedBox(height: 20), _buildBottom()],
        ));
  }

  Widget _buildTop() {
    return ReportCardWidget(
      latitude: widget.latitude,
      longitude: widget.longitude,
      dateTime: widget.dateTime,
      image: widget.image,
      reference: widget.reference,
      comment: widget.comment,
    );
  }
}
