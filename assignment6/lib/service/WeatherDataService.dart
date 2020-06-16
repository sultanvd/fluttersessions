import 'dart:convert';

import 'package:assignment6/model/CityItem.dart';
import 'package:assignment6/model/WeatherData.dart';
import 'package:assignment6/model/WeatherDetails.dart';
import 'package:assignment6/widget/WeatherDetailsWidget.dart';

import '../main.dart';

const String DEGREE_SYMBOL = '\u2103';
const String OPEN_WEATHER_API_KEY = "d901ab865a4d576474d9368ecaa0d7ff";
const String BASE_URL = "api.openweathermap.org";
const String ENDPOINT = "/data/2.5/weather";

class WeatherDataService {
  List<CityItem> cityItems = List();

  WeatherDataService() {
    initCityItems();
  }

  void initCityItems() {
    cityItems.add(CityItem(DEFAULT_DROPDOWN_VALUE, 0, 0));
    cityItems.add(CityItem("Karachi", 24.882481, 67.075949));
    cityItems.add(CityItem("Lahore", 31.503772, 74.360334));
    cityItems.add(CityItem("Islamabad", 33.680061, 73.180500));
    cityItems.add(CityItem("Beijing", 39.994371, 116.369795));
    cityItems.add(CityItem("London", 51.498345, -0.131565));
    cityItems.add(CityItem("New York", 40.666948, -73.917932));
    cityItems.add(CityItem("Paris", 48.854094, 2.332638));
  }

  Future<WeatherData> loadCityDetails(CityItem cityItem) async {
    Map<String, String> queryParam = {
      'lat': cityItem.lat.toString(),
      'lon': cityItem.lon.toString(),
      'appid': OPEN_WEATHER_API_KEY
    };

    var uri = Uri.http(BASE_URL, ENDPOINT, queryParam);

    final response = await client.get(uri.toString());

    print(response);
    if (response != null && response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return convertResultInWeatherData(
          WeatherDetails.fromJson(decodeJson(response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather details');
    }
  }

  WeatherData convertResultInWeatherData(WeatherDetails weatherDetails) {
    String temp = convertKelvinToCelcius(weatherDetails.main.temp).toStringAsFixed(2);
    String tempMin = convertKelvinToCelcius(weatherDetails.main.tempMin).toStringAsFixed(2);
    String tempMax = convertKelvinToCelcius(weatherDetails.main.tempMax).toStringAsFixed(2);
    String status = weatherDetails.weather[0].main;
    String city = weatherDetails.name;
    String country = weatherDetails.sys.country;

    return WeatherData.weatherDetails(temp + DEGREE_SYMBOL, "${tempMin} - ${tempMax} ${DEGREE_SYMBOL}", status, city, country);
  }

  double convertKelvinToCelcius(double tempInKelvin){
    return tempInKelvin - 273;
  }

  Map<String, dynamic> decodeJson(String jsonString){
    return jsonDecode(jsonString);
  }
}
