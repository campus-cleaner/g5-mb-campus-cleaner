import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  @override
  State<NewsPage> createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  late Color myColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Noticias", automaticallyImplyLeading: false),
      bottomNavigationBar:
          const AppNavigationBarWidget(currentIndex: 0, userTypeIndex: 0),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage("assets/images/bg_2.png"),
                  fit: BoxFit.cover),
            ),
            child: _buildList(),
          ),
        ),
      ),
    );
  }

  Widget _buildElement() {
    return AspectRatio(
      aspectRatio: 16 / 9, // Proporción deseada (ancho / alto)
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/new_fisi.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      width: mediaSize.width,
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildPendings(),
          ),
        ),
      ),
    );
  }

  Widget _buildPendings() {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), // Desactiva el desplazamiento para que el padre controle el desplazamiento
      shrinkWrap: true, // Ajusta el tamaño según el contenido
      itemCount: 3,
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: _buildElement(),
        );
      },
    );
  }
}
