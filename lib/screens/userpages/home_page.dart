import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:why_book/constrains.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color intColor = Colors.black.withOpacity(.5);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return CScaffold(
      appBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: Image.network(
              'https://image.shutterstock.com/image-photo/beautiful-water-drop-on-dandelion-260nw-789676552.jpg',
              width: 70,
              height: 70,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(fontSize: 22, color: intColor),
              ),
              const SizedBox(height: 1),
              const Text("User Name",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600))
            ],
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Icon(Icons.notifications,
                  size: 35, color: Colors.black.withOpacity(.5)),
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: TextField(
                style: const TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.search,
                      color: intColor,
                      size: 35,
                    ),
                  ),
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryColr,
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  hintText: " Search Destination",
                  hintStyle: TextStyle(color: intColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CScaffold extends StatelessWidget {
  const CScaffold({Key? key, required this.appBar, required this.body})
      : super(key: key);
  final Widget appBar;
  final Widget body;

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: appBar,
            ),
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: body)
          ],
        ),
      ),
    );
  }
}
