import 'dart:convert';

import 'package:weather_forecast/core/constants/app_constansts.dart';
import 'package:weather_forecast/core/error/error_message_model.dart';
import 'package:weather_forecast/core/error/exceptions.dart';
import 'package:weather_forecast/feature/home/data/model/weather_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/weather.dart';

abstract class BaseWeatherRemoteDataSource {
  Future<Weather> getWeather({String city = 'cairo'});
}

class WeatherRemoteDataSource extends BaseWeatherRemoteDataSource {
  @override
  Future<WeatherModel> getWeather({String city = 'cairo'}) async {
    final response = await http.get(
      Uri.parse(
        '${AppConstants.baseUrl}?q=$city&APPID=${AppConstants.apiKey}',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print('data frim is ${data}');
      return WeatherModel.fromJson(data);
    } else {
      throw ServerException(
          ErrorMessageModel(statusMessage: json.decode(response.body)));
    }
  }
}
