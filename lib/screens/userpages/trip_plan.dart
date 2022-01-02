import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:why_book/components/cscaffold.dart';
import 'package:why_book/constrains.dart';

class TripPlan extends StatelessWidget {
  const TripPlan({Key? key}) : super(key: key);

  @override
  CScaffold build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFF8F8F8),
      statusBarColor: Color(0xFFF8F8F8),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return CScaffold(
        appBar: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: const Color(0xFFEBEBEB)),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 0.8,
                      offset: Offset(0, 5),
                      color: Colors.grey,
                      blurRadius: 8,
                    )
                  ]),
              child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.chevron_left,
                    size: 38,
                  )),
            ),
            const Spacer(),
            Text(
              "Canada trip plan",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 10,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.6,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          menuItem(
                              context: context,
                              day: 1,
                              date: "30 March",
                              isActive: true),
                          menuItem(context: context, day: 2, date: "31 March"),
                          menuItem(context: context, day: 3, date: "1 April"),
                          menuItem(context: context, day: 4, date: "2 April"),
                          menuItem(context: context, day: 5, date: "3 April"),
                          menuItem(context: context, day: 6, date: "4 April"),
                        ],
                      ),
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: Icon(Icons.chevron_right),
                )
              ],
            )
          ],
        ));
  }

  Container menuItem(
      {required BuildContext context,
      required int day,
      required String date,
      bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 12),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isActive ? secondaryColr : Colors.transparent,
                  width: 3))),
      child: Column(children: [
        Text(
          "Day $day",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 3),
        Text(
          date,
          style: const TextStyle(color: Colors.grey),
        )
      ]),
    );
  }
}
