import 'dart:io';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/utils/text_util.dart';

class ReportCardWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String dateTime;
  final File image;
  final String reference;
  final String comment;
  const ReportCardWidget(
      {super.key,
      required this.dateTime,
      required this.image,
      required this.reference,
      required this.comment,
      required this.latitude,
      required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _userInfo(),
          Container(
              decoration: DottedDecoration(
                  shape: Shape.line,
                  linePosition: LinePosition.bottom,
                  color: Colors.black)),
          _imageReport(),
          Container(
              decoration: DottedDecoration(
                  shape: Shape.line,
                  linePosition: LinePosition.bottom,
                  color: Colors.black)),
          _builtDetailInfo(),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.jpg"),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                TextUtil.buildBoldText("Andre Sushino", color: Colors.black),
                const SizedBox(
                  height: 5,
                ),
                TextUtil.buildBlackText("Usuario")
              ],
            )
          ],
        ));
  }

  Widget _imageReport() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtil.buildBoldText("FOTO", color: Colors.black),
          const SizedBox(
            height: 5,
          ),
          TextUtil.buildBlackText(dateTime),
          const SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ))),
        ],
      ),
    );
  }

  Widget _builtDetailInfo() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                children: [
                  TextUtil.buildBoldText("Ubicación"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUtil.buildBlackText(
                      "Latitud: $latitude, Longitud: $longitude")
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  TextUtil.buildBoldText("Referencia"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUtil.buildBlackText(reference)
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextUtil.buildBoldText("Comentario"),
              const SizedBox(
                height: 5,
              ),
              TextUtil.buildBlackText(comment)
            ],
          )
        ]));
  }
}
