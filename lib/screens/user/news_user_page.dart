import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';

class NewsUserPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  const NewsUserPage(
      {super.key, required this.currentIndex, required this.userTypeIndex});
  @override
  State<NewsUserPage> createState() => _NewsUserPageState();
}

class _NewsUserPageState extends State<NewsUserPage> {
  late Color myColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Noticias", automaticallyImplyLeading: false),
      bottomNavigationBar: AppNavigationBarWidget(
          currentIndex: widget.currentIndex,
          userTypeIndex: widget.userTypeIndex),
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
      aspectRatio: 16 / 9,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/new_fisi.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Container()],
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
          child: SizedBox(
              height: 600,
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildPendings(),
                ),
              ))),
    );
  }

  Widget _buildPendings() {
    int itemCount = 3;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, position) {
        return Column(
          children: [
            _buildElement(),
            if (position != itemCount - 1) const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
