library weatherdetailwidget;

import 'package:flutter/material.dart';
import 'package:weatherdetailwidget/src/model/WeatherData.dart';
import 'package:weatherdetailwidget/src/service/WeatherDataService.dart';

WeatherDataService weatherDataService;

class WeatherDetailsWidget extends StatefulWidget {
  double latitude;
  double longitude;

  WeatherDetailsWidget(this.latitude, this.longitude);

  @override
  State<StatefulWidget> createState() {
    weatherDataService = WeatherDataService();
    return WeatherDetailsState(latitude, longitude);
  }
}

class WeatherDetailsState extends State<WeatherDetailsWidget> {
  WeatherData weatherData = WeatherData();
  double latitude;
  double longitude;

  WeatherDetailsState(this.latitude, this.longitude);

  @override
  Widget build(BuildContext context) {
    return weatherDetailsWidget();
  }

  @override
  void initState() {
    calculateWeatherData(latitude, longitude);
  }

  void calculateWeatherData(double latitude, double longitude) {
    var response = weatherDataService.loadCityDetails(latitude, longitude);
    response.then((weatherData) => setWeatherDetails(weatherData),
        onError: (error) => {setWeatherDetails(WeatherData())});
  }

  Widget weatherDetailsWidget() {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  weatherData.temperature,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherData.status,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherData.cityName,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black87))),
          ],
        ));
  }

  void setWeatherDetails(WeatherData weatherDetails) {
    setState(() {
      weatherData = weatherDetails;
    });
  }
}
