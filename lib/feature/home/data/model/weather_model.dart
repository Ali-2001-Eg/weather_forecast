import 'package:weather_forecast/feature/home/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel(
      {required super.temp,
      required super.description,
      required super.icon,
      required super.cityName,
      required super.humidity,
      required super.windSpeed,
      required super.windDirection,
      required super.minMax,
      required super.pressure,
      required super.cloudNo});
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      cityName: json['name'],
      humidity: json['main']['humidity'],
      cloudNo: json['clouds']['all'],
      minMax:
          '${(json['main']['temp_min'] - 273.15 as double).toStringAsFixed(2)}\u00B0/${(json['main']['temp_max'] - 273.15 as double).toStringAsFixed(2)}\u00B0',
      pressure: json['main']['pressure'],
      windSpeed: (json['wind']['speed']).toDouble(),
      windDirection: (json['wind']['deg']).toDouble(),
    );
  }
}
