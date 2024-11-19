import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  late BitmapDescriptor customIcon;
  Set<Marker> markers = {};
  late Timer _timer;
  LatLng _currentPosition = LatLng(40.473523302514145, -3.371948462484766); // Initial position



  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static const CameraPosition _ies_isidra = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.473523302514145, -3.371948462484766),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCustomMarker();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _moveMarker();
    });
  }

  void _moveMarker() {
    const double maxOffsetInMeters = 7.0; // Maximum offset in meters
    const double earthRadiusInMeters = 6378137.0; // Earth's radius

    // Generate random offsets for latitude and longitude
    final random = Random();
    final double latOffset = (random.nextDouble() - 0.5) * 2 * maxOffsetInMeters / earthRadiusInMeters * (180 / pi);
    final double lngOffset = (random.nextDouble() - 0.5) *
        2 *
        maxOffsetInMeters /
        (earthRadiusInMeters * cos(_currentPosition.latitude * pi / 180)) *
        (180 / pi);

    // Update the current position
    double newLatitude = _currentPosition.latitude + latOffset;
    double newLongitude = _currentPosition.longitude + lngOffset;

    _currentPosition = LatLng(newLatitude, newLongitude);

    _addMarker(_currentPosition);

    LatLng _currentPosition2 = LatLng(_currentPosition.latitude+0.000023302514145, _currentPosition.longitude+0.000023302514145); // Initial position

    _addMarker(_currentPosition2);
    LatLng _currentPosition3 = LatLng(_currentPosition.latitude-0.000023302514145, _currentPosition.longitude-0.000023302514145); // Initial position
    _addMarker(_currentPosition3);// Update the marker with the new position
  }

  void _addMarker(LatLng position) async{
    final Uint8List markerImage = await _getBytesFromNetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT1HMr_znxlBHJXzENZfRS7dXMlQgVVzhzJQ&s', // Replace with your image URL
        100); // Desired width for the marker icon
    customIcon = BitmapDescriptor.fromBytes(markerImage);

    final marker = Marker(
      markerId: MarkerId('moving_marker'),
      position: position,
      infoWindow: InfoWindow(title: "Moving Marker"),
      icon: customIcon,
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });

    CameraPosition _ies_isidra = CameraPosition(
        bearing: 192.8334901395799,
        target: _currentPosition,
        tilt: 59.440717697143555,
        zoom: 16.151926040649414);

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_ies_isidra));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To IES Isidra!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_ies_isidra));
  }

  Future<void> _loadCustomMarker() async {
    final Uint8List markerImage = await _getBytesFromNetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT1HMr_znxlBHJXzENZfRS7dXMlQgVVzhzJQ&s', // Replace with your image URL
        100); // Desired width for the marker icon
    customIcon = BitmapDescriptor.fromBytes(markerImage);

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId("marker1"),
          position: LatLng(40.473523302514145, -3.371948462484766),
          infoWindow: InfoWindow(
            title: "LA CUEVA DE MANUEL",
            snippet: "BIENVENIDOS A LA MISTERIOSA Y MAGICA CUEVA DE MANUEL",
          ),
          icon: customIcon,
        ),
      );
    });
  }

  Future<Uint8List> _getBytesFromNetworkImage(String url, int width) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Uint8List bytes = response.bodyBytes;

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: width,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData =
    await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

}