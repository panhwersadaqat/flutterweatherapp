import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';
import 'package:weatherapp/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocation() async {
   Location location = Location();
   await location.getCurrentLocation();
   String url = 'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=[API_KEY]';
   NetworkHelper networkHelper = NetworkHelper(url);

   var weatherData = await networkHelper.getData();
   
   Navigator.push(context, MaterialPageRoute(builder: (context) {
     return LocationScreen(locationWeather: weatherData);
   }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        )
      ),
    );
  }
}
