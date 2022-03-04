import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:travel_app/components.dart';
import 'package:travel_app/constrains.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  GestureDetector build(BuildContext context) {
    const imgUrl = 'https://picsum.photos/230';
    final List<Map> recentItems = [
      {'id': '1', 'name': 'Canada', 'date': '30 March', 'imgUrl': imgUrl},
      {'id': '2', 'name': 'London', 'date': '3 June', 'imgUrl': imgUrl},
      {'id': '3', 'name': 'USA', 'date': '22 August', 'imgUrl': imgUrl},
      {'id': '4', 'name': 'Thrissur', 'date': '24 August', 'imgUrl': imgUrl},
      {'id': '5', 'name': 'Kollam', 'date': '9 December', 'imgUrl': imgUrl},
    ];
    final Color intColor = Colors.black.withOpacity(.5);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CScaffold(
        appBar: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SvgPicture.network(
                      'https://avatars.dicebear.com/api/male/john.svg',
                      height: 50)),
              const SizedBox(width: 20),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Welcome",
                        style: TextStyle(fontSize: 18, color: intColor)),
                    const Text("John",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600))
                  ]),
            ]),
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 30, bottom: 35),
                child: TextField(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.search, color: intColor, size: 20)),
                    suffixIcon: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: secondaryColr),
                        child: const Icon(Icons.filter_list,
                            color: Colors.white, size: 20)),
                    contentPadding: const EdgeInsets.all(4),
                    hintText: "Search Places",
                    hintStyle: TextStyle(
                        color: intColor, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              hometitle("Recent"),
              const SizedBox(height: 5),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: recentItems
                        .map((Map e) => HomeListItem(item: e))
                        .toList()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row hometitle(String title) {
    return Row(children: <Widget>[
      Text(title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
      const Spacer(),
      const Icon(Icons.more_horiz),
      const SizedBox(width: 35)
    ]);
  }
}

class HomeListItem extends StatelessWidget {
  const HomeListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map item;

  @override
  GestureDetector build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/trip-plan'),
      child: Container(
        margin: const EdgeInsets.only(right: 20, top: 20, bottom: 10, left: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        height: 250,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: const Offset(0, 0.5),
                  spreadRadius: 0.5,
                  blurRadius: 8,
                  color: Colors.grey.shade400)
            ]),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(item['imgUrl'], height: 120)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Row(children: <Widget>[
                    Text(item['name'],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.arrow_right, size: 28)
                  ]),
                  Text(item['date'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container homeListBack(Text textWidget) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white54.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: textWidget);
  }
}
