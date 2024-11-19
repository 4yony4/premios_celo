import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late List<double> temperatures;
  late List<int> relativeHumidity;
  late List<double> dewPoints;
  bool isLoading = true;
  double dbLatitude=0.0;
  double dbLongitude=0.0;

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  void getAllData() async{
    Position pos=await _determinePosition();
    print("------->>>>>>>>  $pos");
    await fetchWeatherData(pos);
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


  Future<void> fetchWeatherData(Position pos) async {

    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=${pos.latitude}&longitude=${pos.longitude}&hourly=temperature_2m,relative_humidity_2m,dew_point_2m&forecast_days=1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data["hourly"]["time"][0];
        final hourly = data['hourly'];

        setState(() {
          temperatures = List<double>.from(hourly['temperature_2m']);
          relativeHumidity = List<int>.from(hourly['relative_humidity_2m']);
          dewPoints = List<double>.from(hourly['dew_point_2m']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: temperatures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Hour ${index + 1}'),
            subtitle: Text(
                'Temp: ${temperatures[index]}°C, Humidity: ${relativeHumidity[index]}%, Dew Point: ${dewPoints[index]}°C'),
          );
        },
      ),
    );
  }
}