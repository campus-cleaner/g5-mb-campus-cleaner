import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/new_report_form_page.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final bool isValid;

  const AlertWidget({
    super.key,
    required this.title,
    required this.description,
    required this.isValid,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: isValid
                  ? const Color.fromRGBO(72, 187, 120, 1)
                  : const Color.fromRGBO(246, 173, 85, 1),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          color: isValid ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        description,
                        softWrap: true,
                        style: TextStyle(
                          color: isValid ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Quicksand',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                "assets/images/green-bubbles.svg",
                height: 48,
                width: 40,
                colorFilter: ColorFilter.mode(
                  isValid
                      ? const Color.fromRGBO(39, 103, 73, 1)
                      : const Color.fromRGBO(72, 187, 120, 1),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            top: -13,
            left: 10,
            child: SvgPicture.asset(
              icon,
              height: 45,
              width: 45,
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewReportFormPage()));
              },
              child: SvgPicture.asset(
                "assets/images/close.svg",
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
