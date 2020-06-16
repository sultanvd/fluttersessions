import 'package:assignment6/bloc/weather-bloc.dart';
import 'package:assignment6/model/CityItem.dart';
import 'package:assignment6/model/WeatherData.dart';
import 'package:assignment6/service/WeatherDataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  //WeatherData weatherData = WeatherData();
  String dropDownValue = DEFAULT_DROPDOWN_VALUE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment Week 4", textDirection: TextDirection.ltr),
        ),
        body: BlocProvider(create: (context) {
          return WeatherBloc(weatherDataService);
        }, child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoadingState) {
            dropDownValue = state.cityItem.cityName;
            return showDetailLoadingProgressDialog();
          } else if (state is WeatherFailedState) {
            return getDetailViews(context, WeatherData());
          } else if (state is WeatherSuccessState) {
            return getDetailViews(context, state.weatherData);
          } else {
            return citySelectionWidget(context);
          }
        })));
  }

  Widget showDetailLoadingProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  Widget getDetailViews(BuildContext context, WeatherData weatherData) {
    return Stack(children: <Widget>[
      citySelectionWidget(context),
      weatherDetailsWidget(weatherData)
    ]);
  }

  Widget citySelectionWidget(BuildContext context) {
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
        onChanged: (
          value,
        ) =>
            onDropDownValueChanged(value, context),
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

  Widget weatherDetailsWidget(WeatherData weatherData) {
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

  void onDropDownValueChanged(String dropdownValue, BuildContext context) {
//    setState(() {
//      dropDownValue = dropdownValue;
//    });

    var cityItem = CityItem.getCityItemFromName(
        weatherDataService.cityItems, dropdownValue);
    if (cityItem != null) {
      BlocProvider.of<WeatherBloc>(context).add(WeatherCitySelected(cityItem));
    } else {
      BlocProvider.of<WeatherBloc>(context).add(WeatherLoaded(WeatherData()));
    }
  }
}
