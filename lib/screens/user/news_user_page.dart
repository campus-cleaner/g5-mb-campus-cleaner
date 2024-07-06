import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/models/new.dart';
import 'package:g5_mb_campus_cleaner/services/file_service.dart';
import 'package:g5_mb_campus_cleaner/services/news_service.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
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
  List<New> lista = [];
  @override
  void initState() {
    super.initState();
    _getNews();
  }
  void _getNews() async {
    final service = NewsService();
    final response = await service.getNews();
    if (mounted) {
      setState(() {
        lista = response;
      });
    }
  }
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
  _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
  Widget _buildElement(int position) {
    final service = FileService();
    String url = service.getUrlImageFromServer(lista[position].urlImagen);
    return InkWell(onTap:() async {
      Uri uri = Uri.parse(lista[position].urlExternal!);
      LoggerUtil.logDebug(uri.toString());
      if (!await _launchURL(lista[position].urlExternal!)) {
        throw Exception('Could not launch $uri');
      }
    },
    child: AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(

        decoration:  BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
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
    ));

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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, position) {
          return Column(
            children: [
              _buildElement(position),
              if (position != lista.length - 1) const SizedBox(height: 20),
            ],
          );
          return _buildElement(position);
        });

  }
}
