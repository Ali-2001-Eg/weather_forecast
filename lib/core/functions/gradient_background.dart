import 'package:flutter/material.dart';
import '../enums/weather_condition.dart';

WeatherEnum getWeatherConditionFromDescription(String description) {
  switch (description) {
    case 'clear sky':
      return WeatherEnum.sunny;
    case 'few clouds':
      return WeatherEnum.fewClouds;
    case 'scattered clouds':
      return WeatherEnum.scatteredClouds;
    case 'broken clouds':
      return WeatherEnum.brokenClouds;
    case 'shower rain':
      return WeatherEnum.showerRain;
    case 'rain':
      return WeatherEnum.rainy;
    case 'thunderstorm':
      return WeatherEnum.thunderstorm;
    case 'snow':
      return WeatherEnum.snowy;
    case 'mist':
      return WeatherEnum.mist;
    default:
      return WeatherEnum.others;
  }
}

LinearGradient getGradientForWeatherCondition(WeatherEnum condition) {
  switch (condition) {
    case WeatherEnum.sunny:
      return const LinearGradient(
        colors: [
          Color(0xffffd700),
          Color(0xffffa500),
        ], // Gold to Orange
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.fewClouds:
      return const LinearGradient(
        colors: [
          Color(0xff87cefa),
          Color(0xffb0e0e6)
        ], // Light Sky Blue to Powder Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.scatteredClouds:
      return const LinearGradient(
        colors: [
          Color(0xff87ceeb),
          Color(0xffadd8e6)
        ], // Sky Blue to Light Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.brokenClouds:
      return const LinearGradient(
        colors: [
          Color(0xffb0c4de),
          Color(0xffd3d3d3)
        ], // Light Steel Blue to Light Grey
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.showerRain:
      return const LinearGradient(
        colors: [
          Color(0xff00bfff),
          Color(0xff4682b4)
        ], // Deep Sky Blue to Steel Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.rainy:
      return const LinearGradient(
        colors: [
          Color(0xff1e90ff),
          Color(0xff00bfff)
        ], // Dodger Blue to Deep Sky Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.thunderstorm:
      return const LinearGradient(
        colors: [Color(0xff8b0000), Color(0xff4b0082)], // Dark Red to Indigo
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.snowy:
      return const LinearGradient(
        colors: [Color(0xffffffff), Color(0xffe0ffff)], // White to Light Cyan
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.mist:
      return const LinearGradient(
        colors: [
          Color(0xfff5f5f5),
          Color(0xffa9a9a9)
        ], // White Smoke to Dark Grey
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherEnum.others:
    default:
      return const LinearGradient(
        colors: [
          Color(0xffd3d3d3),
          Color(0xffa9a9a9)
        ], // Light Grey to Dark Grey
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}
