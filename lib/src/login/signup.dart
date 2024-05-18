import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/login/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cellphoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  bool rememberUser = false;
  bool viewFirstPassword = false;
  bool viewSecondPassword = false;

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
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "REGISTRARSE",
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
            primary: true,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextWithColorAndBold("Nombre", fontWeight: FontWeight.bold),
        _buildInputField(nameController),
        const SizedBox(height: 40),
        _buildTextWithColorAndBold("Correo", fontWeight: FontWeight.bold),
        _buildInputField(emailController, isEmail: true),
        const SizedBox(height: 40),
        _buildTextWithColorAndBold("Celular", fontWeight: FontWeight.bold),
        _buildInputField(cellphoneController, isPhone: true),
        const SizedBox(height: 40),
        _buildTextWithColorAndBold("Contraseña", fontWeight: FontWeight.bold),
        _buildInputField(passwordController,
            isPassword: true, passwordNumber: 1),
        const SizedBox(height: 40),
        _buildTextWithColorAndBold("Confirmar Contraseña",
            fontWeight: FontWeight.bold),
        _buildInputField(secondPasswordController,
            isPassword: true, passwordNumber: 2),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildTextWithColorAndBold(String text,
      {Color color = Colors.black, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontFamily: 'Quicksand', fontWeight: fontWeight),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false,
      isEmail = false,
      isPhone = false,
      passwordNumber = 0}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
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
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () {
          debugPrint("Nombre : ${nameController.text}");
          debugPrint("Correo : ${emailController.text}");
          debugPrint("Celular : ${cellphoneController.text}");
          debugPrint("Contraseña : ${passwordController.text}");
          debugPrint("Confirmar contraseña : ${secondPasswordController.text}");
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 31, 172, 90),
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text(
          "Registrarse",
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [_signup()],
      ),
    );
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextWithColorAndBold("¿Ya tienes una cuenta? Inicia sesión "),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: _buildTextWithColorAndBold("aquí",
                color: const Color.fromARGB(255, 31, 172, 90),
                fontWeight: FontWeight.bold))
      ],
    );
  }
}
