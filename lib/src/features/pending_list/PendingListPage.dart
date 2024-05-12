import 'package:flutter/material.dart';

class PendingListPage extends StatefulWidget {
  const PendingListPage({super.key});
  @override
  State<PendingListPage> createState() => _PendingListPage();
}

class _PendingListPage extends State<PendingListPage> {
  late Color myColor;
  late Size mediaSize;
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 60, child: _buildTop()),
        ]),
      ),
    );
  }

  Widget _buildTop(){
    return SizedBox(
      width: mediaSize.width,
      height: 60,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Pendientes",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                fontSize: 30,
                letterSpacing: 2),
          ),
          SizedBox(height: 20,)

        ],
      ),
    );
  }

}