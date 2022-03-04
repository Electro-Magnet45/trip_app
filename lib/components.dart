import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CScaffold extends StatelessWidget {
  const CScaffold(
      {Key? key,
      this.appBar = const SizedBox(height: 0),
      required this.body,
      this.fullScreen = false})
      : super(key: key);
  final Widget appBar;
  final bool fullScreen;
  final Widget body;

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: DefaultTextStyle(
        style: GoogleFonts.poppins(color: Colors.black),
        child: !fullScreen
            ? SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      if (!fullScreen)
                        Padding(
                            padding: const EdgeInsets.all(30), child: appBar),
                      const SizedBox(height: 10),
                      body,
                      if (!fullScreen) const SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    if (!fullScreen)
                      Padding(padding: const EdgeInsets.all(30), child: appBar),
                    const SizedBox(height: 10),
                    body,
                    if (!fullScreen) const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }
}
