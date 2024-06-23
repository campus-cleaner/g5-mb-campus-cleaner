import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/report_to_send_detail_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/format_text_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/app_navigation_bar_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/camera_button_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/custom_app_bar_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportToSendFormUnmsmMemberPage extends StatefulWidget {
  final int currentIndex;
  final int userTypeIndex;
  const ReportToSendFormUnmsmMemberPage(
      {super.key, required this.currentIndex, required this.userTypeIndex});

  @override
  State<ReportToSendFormUnmsmMemberPage> createState() =>
      _ReportToSendFormUnmsmMemberPageState();
}

class _ReportToSendFormUnmsmMemberPageState
    extends State<ReportToSendFormUnmsmMemberPage> {
  late Color myColor;
  late Size mediaSize;
  double? _latitude;
  double? _longitude;
  final _fbKey = GlobalKey<FormBuilderState>();
  File? _image;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      _openCamera();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null && mounted) {
      setState(() {
        _image = File(pickedFile.path);
        _fbKey.currentState?.fields['image']?.didChange(_image?.path);
      });
    }
  }

  Future<void> _requestLocationAndSubmit() async {
    await _getCurrentLocation();
    if (_latitude != 0 && _longitude != 0) {
      if (_image == null) {
        await _requestCameraPermission();
      }
      if (_image != null && (_fbKey.currentState?.saveAndValidate() ?? false)) {
        final formData = _fbKey.currentState!.value;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userName = prefs.getString('userName');
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportToSendDetailUnmsmMemberPage(
                      userName: userName ?? "San marquin@",
                      userTypeIndex: widget.userTypeIndex,
                      currentIndex: widget.currentIndex,
                      formData: formData,
                      dateTime: FormatTextUtil.formatDateTime(DateTime.now()),
                      image: _image!,
                      latitude: _latitude!,
                      longitude: _longitude!,
                    )),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBarWidget(
          title: "Reportar cúmulo de basura", automaticallyImplyLeading: false),
      bottomNavigationBar: AppNavigationBarWidget(
          currentIndex: widget.currentIndex,
          userTypeIndex: widget.userTypeIndex),
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

  Widget _buildContent() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
            key: _fbKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFirstForm(),
                  const SizedBox(height: 20),
                  _buildSecondForm(),
                  const SizedBox(height: 20),
                  _buildSendButton()
                ])));
  }

  Widget _buildFirstForm() {
    return SizedBox(
        width: mediaSize.width,
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildForm(),
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
      children: <Widget>[
        FormBuilderField(
          name: 'image',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Por favor, tome la foto del cúmulo.'),
          ]),
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                  errorText: field.errorText, border: InputBorder.none),
              child: Column(children: <Widget>[
                TextUtil.buildBoldText("Tomar foto"),
                const SizedBox(height: 20),
                CameraButtonWidget(
                    imagePath: "assets/images/camera-icon.png",
                    onPressed: _requestCameraPermission),
                const SizedBox(height: 20),
                _image == null
                    ? TextUtil.buildBlackText(
                        "No se ha tomado foto del cúmulo.")
                    : SizedBox(
                        width: double.infinity,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextUtil.buildBoldText("Referencia"),
        const SizedBox(height: 20),
        _buildInputField("reference", isLocation: true),
        const SizedBox(height: 20),
        TextUtil.buildBoldText("Comentario"),
        const SizedBox(height: 20),
        _buildInputField("comment", isTextBox: true),
      ],
    );
  }

  Widget _buildInputField(String text,
      {isLocation = false, isTextBox = false}) {
    return FormBuilderTextField(
      name: text,
      style: const TextStyle(
          color: Colors.black, fontFamily: 'Quicksand', fontSize: 15),
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.required(errorText: "Campo obligatorio.")]),
      decoration: InputDecoration(
        suffixIcon: isLocation
            ? const Icon(Icons.location_on)
            : const Icon(Icons.text_fields),
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        filled: true,
        fillColor: const Color.fromRGBO(226, 232, 240, 1),
      ),
      keyboardType: isTextBox ? TextInputType.multiline : TextInputType.text,
      maxLines: isTextBox ? 5 : 1,
    );
  }

  Widget _buildSendButton() {
    return ElevatedButton(
        onPressed: () async {
          bool? validation = _fbKey.currentState?.saveAndValidate();
          if (_latitude == null || _longitude == null) {
            await _requestLocationAndSubmit();
          } else {
            if (_image == null) {
              await _requestCameraPermission();
            }
            if (_image != null && (validation ?? false)) {
              final formData = _fbKey.currentState!.value;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? userName = prefs.getString('userName');
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportToSendDetailUnmsmMemberPage(
                            userName: userName!,
                            userTypeIndex: widget.userTypeIndex,
                            currentIndex: widget.currentIndex,
                            formData: formData,
                            dateTime:
                                FormatTextUtil.formatDateTime(DateTime.now()),
                            image: _image!,
                            latitude: _latitude!,
                            longitude: _longitude!,
                          )),
                );
              }
            }
          }
        },
        style: ButtonUtil.buildGreenButton(),
        child: TextUtil.buildBoldText("REPORTAR", color: Colors.white));
  }
}
