import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report_pre_confirm.dart';
import 'package:g5_mb_campus_cleaner/src/features/navigation_bar/campus_app_navigation_bar.dart';
import 'package:g5_mb_campus_cleaner/src/features/navigation_bar/user_campus_app_navigation_bar.dart';
import 'package:g5_mb_campus_cleaner/src/features/reports_by_user/PendingListPageByUser.dart';
import 'package:g5_mb_campus_cleaner/src/login/login.dart';

class ImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const ImageButton(
      {super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Image.asset(imagePath),
    );
  }
}

class DetailReportForm extends StatefulWidget {
  const DetailReportForm({super.key});

  @override
  State<DetailReportForm> createState() => _DetailReportFormState();
}

class _DetailReportFormState extends State<DetailReportForm> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool rememberUser = false;
  bool viewPassword = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Registro',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 31, 172, 90),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 31, 172, 90),
                ),
                accountName: Text(
                  "Usuario XYZ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                accountEmail: Text(
                  "marco.mezaCancho@unmsm.edu.pe",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/147/147142.png"),
                ), //For Image Asset
              ),
              ExpansionTile(
                leading: const Icon(Icons.flag),
                title: const Text("Incidencias"),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text('Historial de Incidencias'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PendingListUserPage(),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: CampusNavigationBar.buildNavUser(context),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage("assets/images/bg_2.png"), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              _buildBottom(),
            ],
          ),
        ));
  }

  Widget _buildBottom() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildWhiteAndBoldText("Reporta lo encontrado"),
                const SizedBox(height: 20),
                _buildFirstForm(),
                const SizedBox(height: 20),
                _buildSecondForm(),
                const SizedBox(height: 20),
                _buildSendButton()
              ],
            )));
  }

  Widget _buildFirstForm() {
    return SizedBox(
        width: mediaSize.width,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildForm(),
              ),
            ),
          ),
        ));
  }

  Widget _buildSecondForm() {
    return SizedBox(
        width: mediaSize.width,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildImageUpload(),
              ),
            ),
          ),
        ));
  }

  Widget _buildImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBlackAndBoldText("Tomar foto"),
        const SizedBox(height: 10),
        Center(
          child: ImageButton(
            imagePath: "assets/images/camera-icon.png",
            onPressed: () {
              // Acción a realizar al presionar el botón
            },
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBlackAndBoldText("Referencia"),
        const SizedBox(height: 10),
        _buildInputField(locationController),
        const SizedBox(height: 10),
        _buildBlackAndBoldText("Comentario"),
        const SizedBox(height: 10),
        _buildTextBox(descriptionController),
      ],
    );
  }

  Widget _buildBlackAndBoldText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
          fontSize: 14),
    );
  }

  Widget _buildWhiteAndBoldText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
          fontSize: 16),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return TextField(
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontFamily: 'Quicksand', fontSize: 14),
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.location_on),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          filled: true,
          fillColor: Color.fromRGBO(226, 232, 240, 1),
        ));
  }

  Widget _buildTextBox(TextEditingController controller) {
    return TextField(
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontFamily: 'Quicksand', fontSize: 14),
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.text_fields),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          filled: true,
          fillColor: Color.fromRGBO(226, 232, 240, 1),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 5);
  }

  Widget _buildSendButton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DetailReportPreConfirmPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 31, 172, 90),
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text(
          "REPORTAR",
          style: TextStyle(color: Colors.white),
        ));
  }
}
