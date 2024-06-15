import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/PendingListPageByResponsible.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_list/pending_list_page.dart';
import 'package:g5_mb_campus_cleaner/src/login/login.dart';
import 'package:g5_mb_campus_cleaner/src/login/welcome_page.dart';
import 'package:g5_mb_campus_cleaner/src/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/src/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/src/widgets/login_background_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/login_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late Color myColor;
  late Size mediaSize;
  bool viewFirstPassword = false;
  bool viewSecondPassword = false;
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
                isPassword: true, passwordNumber: 2),
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
        onPressed: () async {
          if (_fbKey.currentState?.saveAndValidate() ?? false) {
            debugPrint(_fbKey.currentState?.value.toString());
            final username = _fbKey.currentState?.fields["email"]?.value;
            final email = _fbKey.currentState?.fields["email"]?.value;
            final fullname = _fbKey.currentState?.fields["name"]?.value;
            final password = _fbKey.currentState?.fields["password"]?.value;
            final phone = _fbKey.currentState?.fields["cellphone"]?.value;
            var response = await loginService.signUp(
                username: username,
                password: password,
                tokenDevice: null,
                email: email,
                fullname: fullname,
                phone: phone);
            if (response == null) {
              return;
            }
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', response.token);
            if (response.rol == 'ADMIN') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PendingListPage()),
              );
            } else if (response.rol == 'CLEANER') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PendingListResponsiblePage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            }
          }
        },
        style: ButtonUtil.buildGreenButton(),
        child: TextUtil.buildBoldText("REGISTRARSE", color: Colors.white));
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
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: TextUtil.buildBoldText("aquí",
                color: const Color.fromRGBO(31, 172, 90, 1)))
      ],
    );
  }
}
