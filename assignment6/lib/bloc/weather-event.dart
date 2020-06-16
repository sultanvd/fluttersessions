part of 'weather-bloc.dart';

abstract class WeatherEvent extends Equatable{
  const WeatherEvent();

  @override
  List<Object> get props => [];

}

class WeatherCitySelected extends WeatherEvent {
    final CityItem cityItem;

    const WeatherCitySelected(this.cityItem);

    @override
    List<Object> get props => [cityItem];

    @override
    String toString() => 'cityItem $cityItem';

}

class WeatherLoaded extends WeatherEvent {
  final WeatherData weatherData;

  const WeatherLoaded(this.weatherData);

  @override
  List<Object> get props => [weatherData];

  @override
  String toString() => 'Weather $weatherData';
}

class WeatherLoadFailed extends WeatherEvent{
  final String error;
  const WeatherLoadFailed(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'error $error';

}