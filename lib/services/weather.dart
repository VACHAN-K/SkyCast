import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const appid = 'e2ed2e5670b3a723d778f5cfa9862b4e';

class WeatherModel {
  Future<dynamic> getCityWeather(String typedCityName) async {
    var lat, lon;
    apiHelper apihelper = apiHelper(
        'http://api.openweathermap.org/geo/1.0/direct?q=$typedCityName&limit=5&appid=$appid&units=metric');

    var weatherDecodedData = await apihelper.getData();
    try {
      lat = weatherDecodedData[0]['lat'];
      lon = weatherDecodedData[0]['lon'];
    } catch (e) {
      print(e);
      return null;

    }
    apiHelper apihelper2 = apiHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appid&units=metric');
    var weatherDecodedData2 = await apihelper2.getData();

    print(weatherDecodedData2);
    return weatherDecodedData2;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    //this is a created class by me not system class
    await location.getLocation();
    apiHelper apihelper = apiHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&limit=5&appid=$appid&units=metric');
    if (location.longitude == null) return null;
    var weatherDecodedData = await apihelper.getData();
    print(weatherDecodedData);
    return weatherDecodedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int condition) {
    if (condition <700) {
      return 'Bring a ☔️ just in case';
    } else if (condition <800) {
      return 'It\'s windy 🌫️';
    } else if (condition < 803) {
      return 'Clear 🌞 ';
    } else {
      return 'Cloudy ⛅';
    }
  }
}
