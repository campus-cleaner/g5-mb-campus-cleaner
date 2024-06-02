import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report_form.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
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
          const Text(
            "Reporta la basura",
            style: TextStyle(
                color: Color.fromARGB(255, 31, 172, 90),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                fontSize: 35),
          ),
          const SizedBox(height: 20),
          const Text(
            'Participa en mantener nuestra universidad limpia con CampusCleaner. Simplemente toma una foto y reporta cúmulos de basura. Tu contribución es esencial para un entorno más limpio y saludable.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontFamily: 'Quicksand', fontSize: 14),
          ),
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
            MaterialPageRoute(builder: (context) => const DetailReportForm()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 31, 172, 90),
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text(
          "Iniciar",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
              fontSize: 18),
        ));
  }
}
