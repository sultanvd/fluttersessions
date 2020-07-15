import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:weatherdetailwidget/src/model/WeatherData.dart';
import 'package:weatherdetailwidget/src/model/WeatherDetails.dart';


const String DEGREE_SYMBOL = '\u2103';
const String OPEN_WEATHER_API_KEY = "d901ab865a4d576474d9368ecaa0d7ff";
const String BASE_URL = "api.openweathermap.org";
const String ENDPOINT = "/data/2.5/weather";

class WeatherDataService {
  http.Client client = http.Client();

  WeatherDataService() {
  }

  Future<WeatherData> loadCityDetails(double latitude, double longitude) async {
    Map<String, String> queryParam = {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
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
