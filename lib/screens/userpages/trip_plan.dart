import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/route_manager.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/components.dart';
import 'package:travel_app/constrains.dart';

class HomePageController {
  Function(LatLng destLocation)? methodA;
}

class TripPlan extends HookWidget {
  final HomePageController myController = HomePageController();

  TripPlan({Key? key}) : super(key: key);

  @override
  CScaffold build(BuildContext context) {
    final _editMode = useState<bool>(false);
    final _tripInfo = useState<List<Map>>([
      {
        'id': '1',
        'time': '2022-03-05 11:26:13.090',
        'latLng': LatLng(8.89, 76.61),
        'name': 'Place 1',
        'delays': {'1': '20'}
      },
      {'id': '2', 'time': '2022-03-05 11:27:38.715', 'latLng': LatLng(9.95, 76.34), 'name': 'Place 2'},
      {
        'id': '3',
        'time': '2022-03-05 11:28:09.060',
        'latLng': LatLng(9.32, 76.62),
        'name': 'Place 3',
        'delays': {'2': '10'}
      },
      {
        'id': '4',
        'time': '2022-03-05 11:30:09.060',
        'latLng': LatLng(10.52, 76.62),
        'name': 'Place 4',
        'delays': {'1': '2', '2': '10'}
      },
    ]);
    final _latLngList = useState<List<LatLng>>([]);
    final PageController _pageController = usePageController(viewportFraction: 0.88);
    final AnimationController _animeController = useAnimationController(duration: const Duration(milliseconds: 900));
    final Animation<Offset> _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1))
        .animate(CurvedAnimation(parent: _animeController, curve: Curves.ease));

    useEffect(() {
      List<LatLng> latLng = [];
      for (var e in _tripInfo.value) {
        latLng.add(e['latLng']);
      }
      _latLngList.value = latLng;
      return;
    }, []);

    return CScaffold(
        fullScreen: true,
        body: Stack(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _latLngList.value.isNotEmpty
                ? TripMap(
                    latLngList: _latLngList.value,
                    addMarker: (LatLng latlng) async {
                      final TextEditingController contr = TextEditingController();
                      final String destName = await Get.dialog(AlertDialog(
                          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        TextField(controller: contr, keyboardType: TextInputType.multiline, maxLines: null),
                        const SizedBox(height: 10),
                        TextButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
                            onPressed: () => contr.text.isNotEmpty ? Get.back(result: contr.text) : Null,
                            child: const Text('New Destination', style: TextStyle(color: Colors.white)))
                      ])));
                      _latLngList.value.add(latlng);
                      _tripInfo.value.add({
                        'id': (_tripInfo.value.length + 1).toString(),
                        'time': DateTime.now().toString(),
                        'latLng': latlng,
                        'name': destName
                      });
                      Future.delayed(const Duration(seconds: 1), () => contr.dispose());
                    },
                    deleteMarker: (LatLng latlng) {
                      _tripInfo.value = _tripInfo.value.where((e) => e['latLng'] != latlng).toList();
                      _latLngList.value = _latLngList.value.where((e) => e != latlng).toList();
                    },
                    getEditMode: () => _editMode.value,
                    controller: myController)
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: !_editMode.value ? iconBuild(Icons.chevron_left, () => Get.back()) : Container()),
          Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Align(
                  alignment: Alignment.topRight,
                  child: iconBuild(_editMode.value ? Icons.close : Icons.edit, () {
                    final bool val = _editMode.value;
                    _editMode.value = !val;
                    val ? _animeController.reverse() : _animeController.forward();
                  }))),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.5,
              child: SlideTransition(
                position: _offsetAnimation,
                child: PageView(
                    controller: _pageController,
                    onPageChanged: (int newpage) {
                      final LatLng destLocation = _tripInfo.value[newpage]['latLng'];
                      myController.methodA!(destLocation);
                    },
                    children: _tripInfo.value
                        .map((Map e) => tripDetail(e, _pageController, (LatLng latlng) async {
                              final TextEditingController foodContr = TextEditingController();
                              final TextEditingController stayContr = TextEditingController();

                              final Map delays = await Get.dialog(AlertDialog(
                                content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                  TextField(
                                      controller: foodContr,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(hintText: 'Food Delay')),
                                  const SizedBox(height: 20),
                                  TextField(
                                      controller: stayContr,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(hintText: 'Stay Delay')),
                                  const SizedBox(height: 20),
                                  TextButton(
                                      onPressed: () => Get.back(result: {'1': foodContr.text, '2': stayContr.text}),
                                      child: const Text('Edit Delay'))
                                ]),
                              ));
                              print(delays);

                              Future.delayed(const Duration(seconds: 1), () {
                                foodContr.dispose();
                                stayContr.dispose();
                              });
                            }))
                        .toList()),
              ),
            ),
          )
        ]));
  }

  Container tripDetail(Map item, PageController controller, void Function(LatLng) editDelays) {
    final DateTime time = DateTime.parse(item['time']);
    final String period = TimeOfDay(hour: time.hour, minute: time.minute).period.toString().split('.')[1];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text('${time.hour}:${time.minute} ${period.toUpperCase()}'),
                const SizedBox(height: 10),
                Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: item['name'],
                    child: Text(item['name'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1)))
              ])),
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(14)),
                  child: InkWell(
                      onTap: () => controller.nextPage(duration: const Duration(milliseconds: 900), curve: Curves.ease),
                      child: const Icon(Icons.chevron_right, size: 50, color: Colors.white)))
            ],
          ),
          const Spacer(),
          item['delays'] != null
              ? InkWell(
                  onTap: () => editDelays(item['latLng']),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (item['delays']['1'].toString() != 'null')
                      Column(children: <Widget>[const Icon(Icons.restaurant_menu), Text('${item['delays']['1']} min')]),
                    if (item['delays']['2'].toString() != 'null') const SizedBox(width: 20),
                    if (item['delays']['2'].toString() != 'null')
                      Column(children: <Widget>[const Icon(Icons.house), Text('${item['delays']['2']} min')])
                  ]),
                )
              : InkWell(onTap: () => editDelays(item['latLng']), child: Container())
        ],
      ),
    );
  }

  InkWell iconBuild(IconData icon, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: const Color(0xFFEBEBEB)),
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: const <BoxShadow>[
              BoxShadow(spreadRadius: 0.1, color: Color.fromARGB(255, 204, 200, 200), blurRadius: 9)
            ]),
        child: Icon(icon, size: 20),
      ),
    );
  }
}

class TripMap extends StatefulWidget {
  const TripMap({
    Key? key,
    required this.latLngList,
    required this.addMarker,
    required this.deleteMarker,
    required this.getEditMode,
    required this.controller,
  }) : super(key: key);
  final List<LatLng> latLngList;
  final void Function(LatLng) addMarker;
  final void Function(LatLng) deleteMarker;
  final bool Function() getEditMode;
  final HomePageController controller;

  @override
  State<TripMap> createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> with TickerProviderStateMixin {
  MapController? mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  methodA(LatLng destLocation) {
    final _latTween = Tween<double>(begin: mapController?.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(begin: mapController?.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController?.zoom, end: 10.0);

    var controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController?.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)), _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  FlutterMap build(BuildContext context) {
    widget.controller.methodA = methodA;
    List<Marker> _markers = widget.latLngList
        .map((LatLng point) => Marker(
            point: point,
            width: 60,
            height: 60,
            builder: (context) => GestureDetector(
                onLongPress: () {
                  if (!widget.getEditMode() || widget.latLngList.length == 1) return;
                  widget.deleteMarker(point);
                },
                child: const Icon(Icons.location_on, size: 60, color: Colors.red))))
        .toList();

    return FlutterMap(
        mapController: mapController,
        options: MapOptions(
            center: widget.latLngList[0],
            zoom: 10.0,
            onLongPress: (_, LatLng latlng) {
              if (!widget.getEditMode()) return;
              widget.addMarker(latlng);
            }),
        layers: [
          TileLayerOptions(
              minZoom: 1,
              maxZoom: 18,
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          PolylineLayerOptions(
              polylines: <Polyline>[Polyline(points: widget.latLngList, strokeWidth: 5.0, color: Colors.red)]),
          MarkerLayerOptions(markers: _markers)
        ]);
  }
}
