import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/new_report_form_page.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/alert_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/report_card_widget.dart';

class DetailReportPreConfirmPage extends StatefulWidget {
  final Map<String, dynamic> formData;
  final String dateTime;
  final File image;
  final double latitude;
  final double longitude;
  const DetailReportPreConfirmPage(
      {super.key,
      required this.formData,
      required this.dateTime,
      required this.image,
      required this.latitude,
      required this.longitude});

  @override
  State<DetailReportPreConfirmPage> createState() =>
      _DetailReportPreConfirmPage();
}

class _DetailReportPreConfirmPage extends State<DetailReportPreConfirmPage> {
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

  Widget _buildBottom() {
    return ElevatedButton(
        onPressed: () {
          _validateImage();
          _showMyDialog(context);
        },
        style: ButtonUtil.buildGreenButton(),
        child: TextUtil.buildBoldText("ENVIAR", color: Colors.white));
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
      reference: widget.formData['reference'],
      comment: widget.formData['comment'],
    );
  }

  void _validateImage() {
    // Aquí va la lógica de validación de la imagen
    // Por ejemplo, establecer imageIsValid a true o false según el resultado de la validación
    // imageIsValid = true; // ejemplo de resultado de validación
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // El diálogo no se cierra al hacer clic fuera
      builder: (BuildContext context) {
        return imageIsValid
            ? const AlertWidget(
                title: "¡Enviado!",
                description: "El reporte fue enviado correctamente.",
                icon: "assets/images/success.svg",
                isValid: true,
                target: NewReportFormPage())
            : const AlertWidget(
                title: "¡Error!",
                description:
                    "En la foto no se identifica algún desperdicio que debe ser limpiado.",
                icon: "assets/images/fail.svg",
                isValid: false,
                target: NewReportFormPage(),
              );
      },
    );
  }
}
