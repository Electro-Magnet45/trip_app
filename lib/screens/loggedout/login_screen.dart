import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import '../../constrains.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _userName = '';
  String _password = '';
  bool isPassHidden = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 150),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hey,\nLogin Now.",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontFamily: 'Varela Round',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      fadedText(false, "if you are new /  "),
                      const Text(
                        "  Create New",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 60),
              Column(
                children: <Widget>[
                  LoginFormField(
                      value: _userName,
                      onChanged: (inputVal) => setState(() {
                            _userName = inputVal;
                          })),
                  const SizedBox(height: 20),
                  LoginFormField(
                      value: _password,
                      onChanged: (inputVal) => setState(() {
                            _password = inputVal;
                          }),
                      isPassField: true,
                      isPassHidden: isPassHidden,
                      passFun: () {
                        setState(() {
                          isPassHidden = !isPassHidden;
                        });
                      }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      fadedText(false, "Forgot Password /  "),
                      const Text(
                        "  Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 60),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: secondaryColr,
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  const SizedBox(height: 40),
                  fadedText(true, "Register")
                ],
              ),
              const SizedBox(height: 60)
            ],
          ),
        ),
      )),
    );
  }

  Widget fadedText(bool isBtn, String value) {
    return isBtn
        ? GestureDetector(
            onTap: () => Get.toNamed("/register"),
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ))
        : Text(value, style: const TextStyle(color: Colors.grey, fontSize: 16));
  }
}

//ignore: must_be_immutable
class LoginFormField extends StatelessWidget {
  LoginFormField(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.isPassField = false,
      this.isPassHidden = true,
      this.passFun})
      : super(key: key);

  String value;
  void Function(String)? onChanged;
  bool isPassField;
  void Function()? passFun;
  bool isPassHidden;

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      obscureText: isPassField
          ? isPassHidden
              ? true
              : false
          : false,
      cursorColor: primaryColor,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          hintText: isPassField ? "Password" : "Username",
          hintStyle:
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          fillColor: isPassField
              ? value.length > 5
                  ? primaryColor
                  : Colors.grey[200]
              : value.length > 3
                  ? primaryColor
                  : Colors.grey[200],
          filled: true,
          contentPadding:
              const EdgeInsets.only(left: 30, top: 22, right: 20, bottom: 22),
          suffixIcon: LoginFieldIcon(
              isPassField: isPassField,
              isPassHidden: isPassHidden,
              onTap: passFun)),
      onChanged: onChanged,
    );
  }
}

class LoginFieldIcon extends StatelessWidget {
  const LoginFieldIcon(
      {Key? key,
      required this.isPassField,
      required this.isPassHidden,
      required this.onTap})
      : super(key: key);
  final bool isPassField;
  final bool isPassHidden;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return isPassField
        ? isPassHidden
            ? GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.white,
                ),
              )
            : GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.visibility_outlined,
                  color: Colors.white,
                ),
              )
        : const Icon(
            Icons.offline_bolt_outlined,
            color: Colors.white,
          );
  }
}
