import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/PendingListPageByResponsible.dart';
import 'package:g5_mb_campus_cleaner/src/features/reports_by_user/PendingListPageByUser.dart';
import 'package:g5_mb_campus_cleaner/src/login/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool viewPassword = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 110, child: _buildTop()),
          Positioned(bottom: 20, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      height: 500,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Iniciar Sesión",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
        width: mediaSize.width,
        height: 500,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildForm(),
              ),
            ),
          ),
        ));
  }

  Widget _buildForm() {
    return FormBuilder(
        key: _fbKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBlackAndBoldText("Correo"),
            _buildInputField("email",
                validatorForm:
                    FormBuilderValidators.email(errorText: "Correo inválido"),
                isEmail: true),
            const SizedBox(height: 40),
            _buildBlackAndBoldText("Contraseña"),
            _buildInputField("password", isPassword: true),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 20),
            _buildOtherLogin(),
          ],
        ));
  }

  Widget _buildBlackText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontFamily: 'Quicksand'),
    );
  }

  Widget _buildGreenText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(255, 31, 172, 90),
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBlackAndBoldText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand'),
    );
  }

  Widget _buildInputField(String text,
      {String? Function(String?)? validatorForm,
      isPassword = false,
      isEmail = false,
      isPhone = false}) {
    return FormBuilderTextField(
      name: text,
      validator: validatorForm != null
          ? FormBuilderValidators.compose([
              validatorForm,
              FormBuilderValidators.required(errorText: "Campo obligatorio")
            ])
          : FormBuilderValidators.compose(
              [FormBuilderValidators.required(errorText: "Campo obligatorio")]),
      decoration: InputDecoration(
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
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildBlackText("Mantener abierto"),
          ],
        ),
        TextButton(
            onPressed: () {}, child: _buildBlackText("¿Olvidó su contraseña?"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () {
          debugPrint(_fbKey.currentState?.value.toString());
          if (_fbKey.currentState?.saveAndValidate() ?? false) {
            if (_fbKey.currentState?.fields["email"]?.value ==
                'admin@unmsm.edu.pe') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PendingListUserPage()),
              );
            } else if (_fbKey.currentState?.fields["email"]?.value ==
                'cleaner@unmsm.edu.pe') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PendingListResponsiblePage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PendingListUserPage()),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 31, 172, 90),
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text(
          "Iniciar",
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _signup(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBlackText("¿Aún no tienes una cuenta? Regístrate "),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: _buildGreenText("aquí"))
      ],
    );
  }
}
