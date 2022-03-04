import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/route_manager.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/components.dart';

class TripPlan extends StatefulWidget {
  const TripPlan({Key? key}) : super(key: key);

  @override
  State<TripPlan> createState() => _TripPlanState();
}

class _TripPlanState extends State<TripPlan> {
  final ValueNotifier<bool> _editMode = ValueNotifier<bool>(false);
  final ValueNotifier<List<LatLng>> _latLngList = ValueNotifier<List<LatLng>>(
      [LatLng(8.89, 76.61), LatLng(9.95, 76.34), LatLng(9.32, 76.62)]);
  final PageController _controller = PageController(viewportFraction: 0.88);

  @override
  void dispose() {
    super.dispose();
    _editMode.dispose();
    _latLngList.dispose();
    _controller.dispose();
  }

  @override
  CScaffold build(BuildContext context) {
    return CScaffold(
        fullScreen: true,
        body: Stack(children: <Widget>[
          ValueListenableBuilder(
              valueListenable: _latLngList,
              builder: (_, List<LatLng> val, __) => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TripMap(
                    latLngList: val,
                    addMarker: (LatLng latlng) =>
                        _latLngList.value = [..._latLngList.value, latlng],
                    deleteMarker: (LatLng latlng) {
                      final int index = _latLngList.value.indexOf(latlng);
                      _latLngList.value = _latLngList.value
                          .where((e) => _latLngList.value.indexOf(e) != index)
                          .toList();
                    },
                    getEditMode: () => _editMode.value,
                  ))),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ValueListenableBuilder(
                valueListenable: _editMode,
                builder: (_, bool val, __) => !val
                    ? iconBuild(Icons.chevron_left, () => Get.back())
                    : Container()),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Align(
                alignment: Alignment.topRight,
                child: ValueListenableBuilder(
                    valueListenable: _editMode,
                    builder: (_, bool val, __) => iconBuild(
                        val ? Icons.close : Icons.edit,
                        () => _editMode.value = !val))),
          ),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: PageView(controller: _controller, children: <Container>[
                tripDetail(_controller),
                tripDetail(_controller),
                tripDetail(_controller),
                tripDetail(_controller),
              ]),
            ),
          )
        ]));
  }

  Container tripDetail(PageController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('12:45 AM'),
                Flexible(
                  child: Text('sdd dsfjisdbfbss',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                )
              ]),
          const Spacer(),
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(14)),
              child: InkWell(
                onTap: () => controller.nextPage(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.ease),
                child: const Icon(Icons.chevron_right,
                    size: 50, color: Colors.white),
              ))
        ],
      ),
    );
  }

  Container iconBuild(IconData icon, void Function() onTap) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: const Color(0xFFEBEBEB)),
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                spreadRadius: 0.1,
                color: Color.fromARGB(255, 204, 200, 200),
                blurRadius: 9)
          ]),
      child: InkWell(onTap: onTap, child: Icon(icon, size: 20)),
    );
  }
}

class TripMap extends StatelessWidget {
  const TripMap(
      {Key? key,
      required this.latLngList,
      required this.addMarker,
      required this.getEditMode,
      required this.deleteMarker})
      : super(key: key);
  final List<LatLng> latLngList;
  final void Function(LatLng) addMarker;
  final void Function(LatLng) deleteMarker;
  final bool Function() getEditMode;

  @override
  FlutterMap build(BuildContext context) {
    List<Marker> _markers = latLngList
        .map((LatLng point) => Marker(
            point: point,
            width: 60,
            height: 60,
            builder: (context) => GestureDetector(
                onLongPress: () {
                  if (!getEditMode() || latLngList.length == 1) return;
                  deleteMarker(point);
                },
                child: const Icon(Icons.location_on,
                    size: 60, color: Colors.red))))
        .toList();

    return FlutterMap(
        options: MapOptions(
            bounds:
                LatLngBounds(latLngList[0], latLngList[latLngList.length - 1]),
            onLongPress: (_, LatLng latlng) {
              if (!getEditMode()) return;
              addMarker(latlng);
            }),
        layers: [
          TileLayerOptions(
              minZoom: 1,
              maxZoom: 18,
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          PolylineLayerOptions(polylines: <Polyline>[
            Polyline(points: latLngList, strokeWidth: 5.0, color: Colors.red)
          ]),
          MarkerLayerOptions(markers: _markers)
        ]);
  }
}
