import 'dart:async';

import 'package:assignment6/model/CityItem.dart';
import 'package:assignment6/model/WeatherData.dart';
import 'package:assignment6/service/WeatherDataService.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather-event.dart';
part 'weather-state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherDataService weatherDataService;


  WeatherBloc(this.weatherDataService);

  @override
  WeatherState get initialState => WeatherInitialState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if(event is WeatherCitySelected){
      yield WeatherLoadingState(event.cityItem);

      try{
         final weatherData = await weatherDataService.loadCityDetails(event.cityItem);
         this.add(WeatherLoaded(weatherData));
      } catch(error){
        this.add(WeatherLoadFailed(error.toString()));
      }
    }

    if(event is WeatherLoaded){
      yield WeatherSuccessState(event.weatherData);
    }

    if(event is WeatherLoadFailed){
      yield WeatherFailedState(event.error);
    }

  }
  
}