part of 'weather-bloc.dart';

abstract class WeatherState extends Equatable{
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {
  final CityItem cityItem;

  WeatherLoadingState(this.cityItem);

  @override
  List<Object> get props => [cityItem];
}

class WeatherSuccessState extends WeatherState {
  final WeatherData weatherData;

  const WeatherSuccessState(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}

class WeatherFailedState extends WeatherState{
  final String error;

  const WeatherFailedState(this.error);

  @override
  List<Object> get props => [error];
}