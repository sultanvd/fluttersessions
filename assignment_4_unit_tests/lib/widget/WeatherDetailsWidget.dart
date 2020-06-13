import 'package:assignment4/model/CityItem.dart';
import 'package:assignment4/model/WeatherData.dart';
import 'package:assignment4/service/WeatherDataService.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

const String DEFAULT_DROPDOWN_VALUE = "Select City";

WeatherDataService weatherDataService;

class WeatherDetailsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    weatherDataService = WeatherDataService();
    return WeatherDetailsState();
  }
}

class WeatherDetailsState extends State<WeatherDetailsWidget> {
  WeatherData weatherData = WeatherData();
  String dropDownValue = DEFAULT_DROPDOWN_VALUE;

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment Week 4", textDirection: TextDirection.ltr),
        ),
        body: Stack(
          children: <Widget>[citySelectionWidget(), weatherDetailsWidget()],
        ));
  }

  Widget citySelectionWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 16,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (value) => onDropDownValueChanged(value),
        items: CityItem.getCityNameList(weatherDataService.cityItems)
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 18),
                ),
              ));
        }).toList(),
      )
    ]);
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
                child: Text(weatherData.temperatureRange,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherData.status,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.red,
                        fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherData.cityName,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black87))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherData.country,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black87))),
          ],
        ));
  }

  void onDropDownValueChanged(String dropdownValue) {
    setState(() {
      dropDownValue = dropdownValue;
    });

    var cityItem = CityItem.getCityItemFromName(weatherDataService.cityItems, dropdownValue);
    if (cityItem != null) {
      showProgressDialog();
      var response = weatherDataService.loadCityDetails(cityItem);
      response.then((weatherData) => setWeatherDetails(weatherData),
          onError: (error) => {  setWeatherDetails(WeatherData()) })
      .whenComplete(() => hideProgressDialog());
    } else {
      setWeatherDetails(WeatherData());
    }
  }

  void setWeatherDetails(WeatherData weatherDetails) {
    setState(() {
      hideProgressDialog();
      weatherData = weatherDetails;
    });
  }

  void showProgressDialog() {
    if (pr == null) {
      pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: true);
    }

    pr.show();
  }

  void hideProgressDialog() {
    if (pr != null) {
      pr.hide();
    }
  }
}
