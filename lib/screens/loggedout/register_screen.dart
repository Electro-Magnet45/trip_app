import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import '../userpages/home_page.dart';

import '../../constrains.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String userName = "";
  String password = "";
  String fullName = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              Center(
                  child: Image(
                image: const AssetImage('assets/sign_up.png'),
                height: MediaQuery.of(context).size.height / 2.5,
              )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                    vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontFamily: 'Varela Round',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: const [
                        RegisterSocialMedia(
                            iconUrl: 'assets/icons8-google.svg'),
                        RegisterSocialMedia(
                            iconUrl: 'assets/icons8-facebook.svg'),
                        RegisterSocialMedia(iconUrl: 'assets/icons8-google.svg')
                      ],
                    ),
                    const SizedBox(height: 40),
                    fadedText(false, "Or, register with email"),
                    const SizedBox(height: 40),
                    RegisterFormField(
                        placeholder: "Username",
                        icon: Icons.alternate_email_outlined,
                        value: userName,
                        onChange: (value) {
                          userName = value;
                        }),
                    const SizedBox(height: 20),
                    RegisterFormField(
                      placeholder: "Password",
                      icon: Icons.lock_open_outlined,
                      isPass: true,
                      value: password,
                      onChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    RegisterFormField(
                      placeholder: "Full Name",
                      icon: Icons.person_outlined,
                      value: fullName,
                      onChange: (value) {
                        setState(() {
                          fullName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Get.offAll(() => const Home());
                        },
                        child: const Text(
                          "Register",
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
                    fadedText(true, "Login"),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget fadedText(bool isBtn, String value) {
    return isBtn
        ? GestureDetector(
            onTap: () => Get.back(),
            child: Center(
                child: Text(
              value,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            )))
        : Center(
            child: Text(
            value,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ));
  }
}

// ignore: must_be_immutable
class RegisterFormField extends StatelessWidget {
  RegisterFormField(
      {Key? key,
      required this.placeholder,
      required this.icon,
      this.isPass = false,
      required this.value,
      required this.onChange})
      : super(key: key);

  final String placeholder;
  final IconData icon;
  final bool isPass;
  final void Function(String) onChange;
  String value;

  @override
  TextField build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: isPass ? true : false,
      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: placeholder,
        hintStyle: const TextStyle(fontWeight: FontWeight.normal),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}

class RegisterSocialMedia extends StatelessWidget {
  const RegisterSocialMedia({
    Key? key,
    required this.iconUrl,
  }) : super(key: key);
  final String iconUrl;

  @override
  Expanded build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: SvgPicture.asset(iconUrl, height: 40),
      ),
    );
  }
}
