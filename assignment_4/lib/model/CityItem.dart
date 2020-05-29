import 'dart:ffi';

class CityItem{
  String cityName;
  double lat;
  double lon;


  CityItem(this.cityName, this.lat, this.lon);

  static List<String> getCityNameList(List<CityItem> cities){
    var cityName = List<String>();
    cities.forEach((city) => cityName.add(city.cityName));

    return cityName;
  }


  static CityItem getCityItemFromName(List<CityItem> cities, String cityName){
    return cities.firstWhere((city) => city.cityName == cityName);
  }


}