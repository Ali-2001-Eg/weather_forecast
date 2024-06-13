import 'package:dartz/dartz.dart';
import 'package:weather_forecast/feature/home/domain/entities/weather.dart';

import '../../../../core/error/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, Weather>> getWeather({String city = 'Cairo'});
}
