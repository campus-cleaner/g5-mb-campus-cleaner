import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/services/login_service.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_list_cleaner_page.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/report_to_asign_list_admin_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/sign_up_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/welcome_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/utils/button_util.dart';
import 'package:g5_mb_campus_cleaner/utils/text_util.dart';
import 'package:g5_mb_campus_cleaner/widgets/alert_widget.dart';
import 'package:g5_mb_campus_cleaner/widgets/login_background_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final loginService = LoginService();
  late Color myColor;
  late Size mediaSize;
  bool viewPassword = false;

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
                child: TextUtil.buildBigWhiteAndBoldText("Iniciar Sesión"))));
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
            TextUtil.buildBoldText("Correo"),
            _buildInputField("email", "Escribe tu correo",
                validatorForm:
                    FormBuilderValidators.email(errorText: "Correo inválido."),
                isEmail: true),
            const SizedBox(height: 40),
            TextUtil.buildBoldText("Contraseña"),
            _buildInputField("password", "Escribe tu contraseña",
                isPassword: true),
            const SizedBox(height: 30),
            _buildLoginButton(),
            const SizedBox(height: 30),
            _signup(),
          ],
        ));
  }

  Widget _buildInputField(String text, String placeholder,
      {String? Function(String?)? validatorForm,
      isPassword = false,
      isEmail = false,
      isPhone = false}) {
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
                    viewPassword = !viewPassword;
                  });
                },
              )
            : isEmail
                ? const Icon(Icons.email)
                : isPhone
                    ? const Icon(Icons.phone_android)
                    : const Icon(Icons.text_fields),
      ),
      obscureText: isPassword ? !viewPassword : false,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (_fbKey.currentState?.saveAndValidate() ?? false) {
            final user = _fbKey.currentState?.fields["email"]?.value;
            final pass = _fbKey.currentState?.fields["password"]?.value;
            var response = await loginService.login(
                username: user, password: pass, tokenDevice: null);
            if (!mounted) return;
            if (response == null) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const AlertWidget(
                      title: "¡Error!",
                      description: "El usuario no existe.",
                      icon: "assets/images/fail.svg",
                      isValid: false);
                },
              );
              return;
            }
            await prefs.setString('token', response.token);
            if (!mounted) return;
            if (response.rol == 'ADMIN') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReportToAsignListAdminPage()),
              );
            } else if (response.rol == 'CLEANER') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ReportToResolveListCleanerPage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WelcomeUnmsmMemberPage()),
              );
            }
          }
        },
        style: ButtonUtil.buildGreenButton(),
        child: TextUtil.buildBoldText("INICIAR", color: Colors.white));
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextUtil.buildBlackText("¿Aún no tienes una cuenta? Regístrate "),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpUnmsmMemberPage()),
              );
            },
            child: TextUtil.buildBoldText("aquí",
                color: const Color.fromRGBO(31, 172, 90, 1)))
      ],
    );
  }
}
