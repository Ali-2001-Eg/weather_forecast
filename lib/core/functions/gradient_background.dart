import 'package:flutter/material.dart';

import '../enums/weather_condition.dart';

List<Color> getGradientColors(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.sunny:
      return [
        const Color(0xFFFFD700),
        const Color(0xFFFF8C00)
      ]; // Gold to Dark Orange
    case WeatherCondition.fewClouds:
      return [
        const Color(0xFFA2C4E6),
        const Color(0xFFF0E68C)
      ]; // Light Blue to Khaki
    case WeatherCondition.cloudy:
      return [
        const Color(0xFFD3D3D3),
        const Color(0xFF696969)
      ]; // Light Gray to Dim Gray
    case WeatherCondition.rainy:
      return [
        const Color(0xFF4A90E2),
        const Color(0xFF007AFF)
      ]; // Sky Blue to Bright Blue
    case WeatherCondition.thunderstorm:
      return [
        const Color(0xFF232526),
        const Color(0xFF414345)
      ]; // Charcoal to Dark Slate
    case WeatherCondition.snowy:
      return [
        const Color(0xFFB3E5FC),
        const Color(0xFFE1F5FE)
      ]; // Light Blue to Light Cyan
    case WeatherCondition.mist:
      return [
        const Color(0xFFBDBDBD),
        const Color(0xFFE0E0E0)
      ]; // Gray to Light Gray
    case WeatherCondition.others:
    default:
      return [
        const Color(0xFF6441A5),
        const Color(0xFF2a0845)
      ]; // Twilight gradient (Blue to Purple); // Default to a plain white gradient
  }
}
