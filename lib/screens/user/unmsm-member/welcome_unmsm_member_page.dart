import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/report_to_send_form_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';

class WelcomeUnmsmMemberPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  const WelcomeUnmsmMemberPage(
      {super.key, required this.currentIndex, required this.userTypeIndex});

  @override
  State<WelcomeUnmsmMemberPage> createState() => _WelcomeUnmsmMemberPageState();
}

class _WelcomeUnmsmMemberPageState extends State<WelcomeUnmsmMemberPage> {
  late Color myColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(226, 232, 240, 1),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          _buildContent(),
        ]),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/welcome-image.png"),
          const SizedBox(height: 20),
          TextUtil.buildRobotoTitleText("Reporta la basura",
              color: const Color.fromRGBO(31, 172, 90, 1)),
          const SizedBox(height: 20),
          Center(
              child: TextUtil.buildBlackText(
                  "Participa en mantener nuestra universidad limpia con CampusCleaner. Simplemente toma una foto y reporta cúmulos de basura. Tu contribución es esencial para un entorno más limpio y saludable.",
                  centered: true)),
          const SizedBox(height: 35),
          _buildInitialButton(),
        ],
      ),
    );
  }

  Widget _buildInitialButton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportToSendFormUnmsmMemberPage(
                    userTypeIndex: widget.userTypeIndex,
                    currentIndex: widget.currentIndex)),
          );
        },
        style: ButtonUtil.buildGreenButton(),
        child: TextUtil.buildBoldText("INICIAR", color: Colors.white));
  }
}
