import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/global/env.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_list_cleaner_page.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/report_to_asign_list_admin_page.dart';
import 'package:g5_mb_campus_cleaner/screens/log_in_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/welcome_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/services/login_service.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/alert_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/login_background_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpUnmsmMemberPage extends StatefulWidget {
  const SignUpUnmsmMemberPage({super.key});
  @override
  State<SignUpUnmsmMemberPage> createState() => _SignUpUnmsmMemberPageState();
}

class _SignUpUnmsmMemberPageState extends State<SignUpUnmsmMemberPage> {
  late Color myColor;
  late Size mediaSize;
  bool viewFirstPassword = false;
  bool viewSecondPassword = false;
  bool isLoading = false;
  final _fbKey = GlobalKey<FormBuilderState>();
  final loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
          child: SingleChildScrollView(
              child: Column(children: [_buildTop(), _buildBottom()]))),
    );
  }

  Widget _buildTop() {
    return LoginBackgroundWidget(
        child: SizedBox(
            width: mediaSize.width,
            height: 280,
            child: Center(
                child: TextUtil.buildBigWhiteAndBoldText("Registrarse"))));
  }

  Widget _buildBottom() {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
        key: _fbKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtil.buildBoldText("Nombre"),
            _buildInputField("name", "Escribe tu nombre", isName: true),
            const SizedBox(height: 40),
            TextUtil.buildBoldText("Correo"),
            _buildInputField("email", "Escribe tu correo",
                validatorForm:
                    FormBuilderValidators.email(errorText: "Email inválido"),
                isEmail: true),
            const SizedBox(height: 40),
            TextUtil.buildBoldText("Celular"),
            _buildInputField("cellphone", "Escribe tu celular",
                validatorForm: FormBuilderValidators.numeric(
                    errorText: "Debe ser un número válido"),
                isPhone: true),
            const SizedBox(height: 40),
            TextUtil.buildBoldText("Contraseña"),
            _buildInputField("password", "Escribe tu contraseña",
                isPassword: true, passwordNumber: 1),
            const SizedBox(height: 40),
            TextUtil.buildBoldText("Confirmar Contraseña"),
            _buildInputField(
                "secondPassword", "Vuelve a escribir tu contraseña",
                isPassword: true, passwordNumber: 2, validatorForm: (val) {
              if (val != _fbKey.currentState?.fields['password']?.value) {
                return "Las contraseñas no coinciden.";
              }
              return null;
            }),
            const SizedBox(height: 30),
            _buildSignUpButton(),
            const SizedBox(height: 30),
            _login(),
          ],
        ));
  }

  Widget _buildInputField(String text, String placeholder,
      {String? Function(String?)? validatorForm,
      isPassword = false,
      isEmail = false,
      isPhone = false,
      isName = false,
      passwordNumber = 0}) {
    return FormBuilderTextField(
      name: text,
      style: const TextStyle(
          color: Colors.black, fontFamily: 'Quicksand', fontSize: 15),
      validator: validatorForm != null
          ? FormBuilderValidators.compose([
              validatorForm,
              FormBuilderValidators.required(errorText: "Campo obligatorio.")
            ])
          : FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Campo obligatorio.")
            ]),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(
            color: Colors.black, fontFamily: 'Quicksand', fontSize: 15),
        suffixIcon: isPassword
            ? IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  setState(() {
                    passwordNumber == 1
                        ? viewFirstPassword = !viewFirstPassword
                        : viewSecondPassword = !viewSecondPassword;
                  });
                },
              )
            : isEmail
                ? const Icon(Icons.email)
                : isPhone
                    ? const Icon(Icons.phone_android)
                    : const Icon(Icons.text_fields),
      ),
      obscureText: isPassword
          ? passwordNumber == 1
              ? !viewFirstPassword
              : !viewSecondPassword
          : false,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : isName
                  ? TextInputType.name
                  : TextInputType.text,
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
        onPressed: isLoading
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                if (_fbKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_fbKey.currentState?.value.toString());
                  final username = _fbKey.currentState?.fields["email"]?.value;
                  final email = _fbKey.currentState?.fields["email"]?.value;
                  final fullname = _fbKey.currentState?.fields["name"]?.value;
                  final password =
                      _fbKey.currentState?.fields["password"]?.value;
                  final phone = _fbKey.currentState?.fields["cellphone"]?.value;
                  var response = await loginService.signUp(
                      username: username,
                      password: password,
                      tokenDevice: null,
                      email: email,
                      fullname: fullname,
                      phone: phone);
                  if (!mounted) return;
                  if (response == null) {
                    setState(() {
                      isLoading = false;
                    });
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AlertWidget(
                            title: "¡Error!",
                            description: "El usuario no ha podido registrarse.",
                            icon: "assets/images/fail.svg",
                            isValid: false);
                      },
                    );
                    return;
                  }
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  late Widget target;
                  await prefs.setString('token', response.token);
                  await prefs.setString('userName', response.userName);
                  if (!mounted) return;
                  if (response.rol == 'ADMIN') {
                    target = const ReportToAsignListAdminPage(
                        userTypeIndex: Environment.adminIndex, currentIndex: 0);
                  } else if (response.rol == 'CLEANER') {
                    target = const ReportToResolveListCleanerPage(
                        userTypeIndex: Environment.cleanerIndex,
                        currentIndex: 0);
                  } else {
                    target = const WelcomeUnmsmMemberPage(
                        userTypeIndex: Environment.unmsmMemberIndex,
                        currentIndex: 0);
                  }
                  setState(() {
                    isLoading = false;
                  });
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertWidget(
                        title: "¡Registrado!",
                        description: "El usuario fue registrado correctamente.",
                        icon: "assets/images/success.svg",
                        isValid: true,
                        target: target,
                      );
                    },
                  );
                  return;
                }
                setState(() {
                  isLoading = false;
                });
              },
        style: ButtonUtil.buildGreenButton(),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : TextUtil.buildBoldText("REGISTRARSE", color: Colors.white));
  }

  Widget _login() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextUtil.buildBlackText("¿Ya tienes una cuenta? Inicia sesión "),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogInPage()),
              );
            },
            child: TextUtil.buildBoldText("aquí",
                color: const Color.fromRGBO(31, 172, 90, 1)))
      ],
    );
  }
}
