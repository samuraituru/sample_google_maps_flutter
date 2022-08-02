import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Google Maps Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoogleMapSample(),
    );
  }
}

class GoogleMapSample extends StatefulWidget {
  @override
  _GoogleMapSampleState createState() => _GoogleMapSampleState();
}

class _GoogleMapSampleState extends State<GoogleMapSample> {
  final _controller = Completer<GoogleMapController>();
  final _markers = <Marker>{};
  LatLng? ontapLatLng;
  final initLatLng = const LatLng(35.675, 139.770);
  double maxZoomLevel = 18;
  double minZoomLevel = 6;

  late final _initPosition = CameraPosition(target: initLatLng, zoom: 14.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps Flutter"),
      ),
      body: GoogleMap(
        onTap: (LatLng latLng) async {
          ontapLatLng = latLng;
          await markerCreate(latLng);
        },
        initialCameraPosition: _initPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _onMapCreated(controller);
        },
        minMaxZoomPreference: MinMaxZoomPreference(minZoomLevel, maxZoomLevel),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onCameraMove: (cameraPosition) async {
          const baseNumber = 10;
          var floorZoomValue =
              (cameraPosition.zoom * baseNumber).floor() / baseNumber;
          final strZoomValue = floorZoomValue.toString();
          print('比率は${cameraPosition.zoom}');
          print(rangeValueReturn(strZoomValue));
          if (rangeValueReturn(strZoomValue) == true) {
            print("動いてるで");
            await canvasZoomAction(cameraPosition.zoom);
          }
        },
      ),
    );
  }

  // zoomValueが1~16かつ「x.0」の場合はTrue、それ以外はFalseを返す
  bool rangeValueReturn(String zoomValue) {
    String command = zoomValue;
    switch (command) {
      case '1.0':
        return true;
      case '2.0':
        return true;
      case '3.0':
        return true;
      case '4.0':
        return true;
      case '5.0':
        return true;
      case '6.0':
        return true;
      case '7.0':
        return true;
      case '8.0':
        return true;
      case '9.0':
        return true;
      case '10.0':
        return true;
      case '11.0':
        return true;
      case '12.0':
        return true;
      case '13.0':
        return true;
      case '14.0':
        return true;
      case '15.0':
        return true;
      case '16.0':
        return true;
      default:
        return false;
    }
  }

  // マップの初期構築
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    String value = await DefaultAssetBundle.of(context)
        .loadString('lib/json/mapstyle.json'); // Jsonファイルをcustom-mapを読み込む
    GoogleMapController futureController = await _controller.future;
    futureController.setMapStyle(value); // Controllerを使ってMapをSetする
  }

  // CanvasMarkerのonTap時CallBack
  Future<void> onTapCanvasCallBack(LatLng latLng) async {
    final Uint8List canvasMarker = await getBytesFromCanvas(100, 100);

    final tapMarker =
        canvasReturn(await canvasMarker, latLng, onTapCanvasCallBack);
    _markers.add(tapMarker);
    print('Pinをタップしたよ');
    setState(() {});
  }

  // Map上でZoomを行った際のActionを定義
  Future<void> canvasZoomAction(double zoomRatio) async {
    print('🥶zoomRatioは${zoomRatio.floor()}');
    final tmpMarkers = Set.from(_markers);
    final Uint8List canvasMarker = await getBytesFromCanvas(
        zoomRatio.toInt().floor() * 4, zoomRatio.toInt().floor() * 4);
    for (final marker in tmpMarkers) {
      final latLng = marker.position;
      final initMarker =
          canvasReturn(await canvasMarker, latLng, onTapCanvasCallBack);
      markerAdd(initMarker);
    }
    setState(() {});
  }

  // CanvasMarkerを作成する関数
  Future<void> markerCreate(LatLng latLng) async {
    // 初期のCanvasサイズを指定
    final Uint8List markerIcon = await getBytesFromCanvas(50, 50);

    Marker initMarker = Marker(
      markerId: MarkerId(latLng.toString()), // IDにはlatLngを使用する
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: latLng,
      onTap: () => onTapCanvasCallBack(latLng),
    );

    setState(() {
      markerAdd(initMarker);
    });
  }

  // 引数で貰ったmarkerをmarkersへ追加する
  void markerAdd(Marker marker) {
    _markers.add(marker);
  }

  @override
  void initState() {
    super.initState();
  }
}

// 引数で貰った情報を元にCanvasを作成しリターンする関数
Marker canvasReturn(
    Uint8List markerIcon, LatLng latLng, Future<void> Function(LatLng) onTap) {
  return Marker(
    markerId: MarkerId(latLng.toString()),
    icon: BitmapDescriptor.fromBytes(markerIcon),
    position: latLng,
    onTap: () => onTap(latLng),
  );
}

// Zoom値を元に濃度別のYellowパレットを返す関数
Color colorReturn(int value) {
  String parameters = value.toString();
  int yellowValue = yellowValueGet(parameters);
  ui.Color? yellow = Colors.yellow[yellowValue];
  print(yellow);
  return yellow!;
}

// Yellowパレットに渡す数字を返す関数
int yellowValueGet(String zoomValue) {
  String value = zoomValue;
  switch (value) {
    case '1.0':
      return 400;
    case '2.0':
      return 400;
    case '3.0':
      return 400;
    case '4.0':
      return 300;
    case '5.0':
      return 300;
    case '6.0':
      return 300;
    case '7.0':
      return 200;
    case '8.0':
      return 200;
    case '9.0':
      return 200;
    case '10.0':
      return 100;
    case '11.0':
      return 100;
    case '12.0':
      return 100;
    case '13.0':
      return 100;
    case '14.0':
      return 50;
    case '15.0':
      return 50;
    case '16.0':
      return 50;
    default:
      return 500;
  }
}

// 引数からUint8List型でCancvasをリターンする関数
Future<Uint8List> getBytesFromCanvas(int width, int height) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  Color yellowcolors = colorReturn(width);
  final Paint paint = Paint()..color = yellowcolors;
  final Radius radius = Radius.circular(30.0);

  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      paint);

  TextPainter Painter = TextPainter(textDirection: TextDirection.ltr);
  Painter.text = TextSpan(
    text: 'H',
    style: TextStyle(fontSize: 25.0, color: Colors.white),
  );
  Painter.layout();
  Painter.paint(
      canvas,
      Offset((width * 0.5) - Painter.width * 0.5,
          (height * 0.5) - Painter.height * 0.5));
  final img = await pictureRecorder.endRecording().toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}
