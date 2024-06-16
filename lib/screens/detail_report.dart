import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/report_card_widget.dart';

class DetailReportPage extends StatefulWidget {
  final String reference;
  final String comment;
  final String dateTime;
  final File image;
  final double latitude;
  final double longitude;
  const DetailReportPage(
      {super.key,
      required this.reference,
      required this.comment,
      required this.dateTime,
      required this.image,
      required this.latitude,
      required this.longitude});

  @override
  State<DetailReportPage> createState() => _DetailReportPage();
}

class _DetailReportPage extends State<DetailReportPage> {
  late Color myColor;
  late Size mediaSize;
  late bool imageIsValid;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    imageIsValid = false;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Detalle del reporte", automaticallyImplyLeading: true),
      bottomNavigationBar:
          const AppNavigationBarWidget(userTypeIndex: 0, currentIndex: 0),
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

  Widget _buildContent() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [_buildTop()],
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
