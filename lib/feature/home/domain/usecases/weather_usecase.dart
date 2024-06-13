// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:weather_forecast/core/error/failure.dart';
import 'package:weather_forecast/feature/home/data/repository/base_repository.dart';
import 'package:weather_forecast/feature/home/domain/entities/weather.dart';

abstract class BaseUseCase<T> {
  Future<Either<Failure, T>> call({String parameters});
}
class WeatherUseCase extends BaseUseCase {
  BaseRepository baseRepository;
  WeatherUseCase({
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, Weather>> call({String parameters = 'cairo'}) {
    return baseRepository.getWeather(city: parameters);
  }

}
