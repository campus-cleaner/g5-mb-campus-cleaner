import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/report_to_send_form_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/services/reports_service.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/alert_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/report_card_widget.dart';

class ReportToSendDetailUnmsmMemberPage extends StatefulWidget {
  final String userName;
  final int currentIndex;
  final int userTypeIndex;
  final Map<String, dynamic> formData;
  final String dateTime;
  final File image;
  final double latitude;
  final double longitude;
  const ReportToSendDetailUnmsmMemberPage(
      {super.key,
      required this.userName,
      required this.formData,
      required this.dateTime,
      required this.image,
      required this.latitude,
      required this.longitude,
      required this.currentIndex,
      required this.userTypeIndex});

  @override
  State<ReportToSendDetailUnmsmMemberPage> createState() =>
      _ReportToSendDetailUnmsmMemberPageState();
}

class _ReportToSendDetailUnmsmMemberPageState
    extends State<ReportToSendDetailUnmsmMemberPage> {
  late Color myColor;
  late Size mediaSize;
  late bool imageIsValid;
  late bool somethingHasGoneWrong;
  late bool isSending;
  late String? savedFilePath;

  @override
  void initState() {
    super.initState();
    isSending = false;
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    somethingHasGoneWrong = false;
    imageIsValid = false;
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
      onPressed: isSending
          ? null
          : () async {
              setState(() {
                isSending = true;
              });
              await _validateImage();
              if (mounted) {
                _showMyDialog(context);
              }
            },
      style: ButtonUtil.buildGreenButton(),
      child: isSending
          ? const SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3.0,
              ),
            )
          : TextUtil.buildBoldText("ENVIAR", color: Colors.white),
    );
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
      userName: widget.userName,
      latitude: widget.latitude,
      longitude: widget.longitude,
      dateTime: widget.dateTime,
      image: widget.image,
      reference: widget.formData['reference'],
      comment: widget.formData['comment'],
    );
  }

  Future<void> _validateImage() async {
    final service = ReportService();
    final validationResponse = await service.reportImage(widget.image);
    LoggerUtil.logInfo(validationResponse.message!);
    if (validationResponse.code == "200") {
      imageIsValid = true;
      savedFilePath = validationResponse.data;
      final savingResponse = await service.registerReport(
          savedFilePath!,
          widget.formData['reference'],
          widget.formData['comment'],
          widget.latitude,
          widget.longitude,
          widget.dateTime);
      somethingHasGoneWrong = savingResponse.code != "200";
    } else {
      imageIsValid = false;
      somethingHasGoneWrong = validationResponse.code != "400";
    }
    setState(() {
      isSending = false;
    });
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return somethingHasGoneWrong
            ? AlertWidget(
                title: "¡Error!",
                description: "No se ha podido podido procesar su reporte.",
                icon: "assets/images/fail.svg",
                isValid: false,
                target: ReportToSendFormUnmsmMemberPage(
                    userTypeIndex: widget.userTypeIndex,
                    currentIndex: widget.currentIndex),
              )
            : imageIsValid
                ? AlertWidget(
                    title: "¡Enviado!",
                    description: "El reporte fue enviado correctamente.",
                    icon: "assets/images/success.svg",
                    isValid: true,
                    target: ReportToSendFormUnmsmMemberPage(
                        userTypeIndex: widget.userTypeIndex,
                        currentIndex: widget.currentIndex))
                : AlertWidget(
                    title: "¡Error!",
                    description:
                        "En la foto no se identifica algún desperdicio que debe ser limpiado.",
                    icon: "assets/images/fail.svg",
                    isValid: false,
                    target: ReportToSendFormUnmsmMemberPage(
                        userTypeIndex: widget.userTypeIndex,
                        currentIndex: widget.currentIndex),
                  );
      },
    );
  }
}
