// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Weather extends Equatable {
  final double temp;
  final String description;
  final String icon;
  final String cityName;
  final String minMax;
  final int pressure;
  final int humidity;
  final int cloudNo;
  final double windSpeed;
  final double windDirection;
  const Weather({
    required this.temp,
    required this.description,
    required this.icon,
    required this.cityName,
    required this.minMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.cloudNo,
  });

  @override
  List<Object?> get props => [
        temp,
        description,
        icon,
        cityName,
        humidity,
        windSpeed,
        windDirection,
        minMax,
        pressure,
        cloudNo,
      ];
}
