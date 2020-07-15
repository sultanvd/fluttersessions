const String DEFAULT_VALUE = "N/A";

class WeatherData{
  String temperature;
  String temperatureRange;
  String status ;
  String cityName;
  String country;

  WeatherData(){
    temperature = DEFAULT_VALUE;
    temperatureRange = DEFAULT_VALUE;
    status = DEFAULT_VALUE;
    cityName = DEFAULT_VALUE;
    country = DEFAULT_VALUE;
  }

  WeatherData.weatherDetails(this.temperature, this.temperatureRange,
      this.status,
      this.cityName, this.country);


}