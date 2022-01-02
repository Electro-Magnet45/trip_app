import 'package:flutter/material.dart';

class CScaffold extends StatelessWidget {
  const CScaffold({Key? key, required this.appBar, required this.body})
      : super(key: key);
  final Widget appBar;
  final Widget body;

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: appBar,
                ),
                const SizedBox(height: 10),
                body,
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
