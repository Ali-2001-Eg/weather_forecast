// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:weather_forecast/core/error/exceptions.dart';

import 'package:weather_forecast/core/error/failure.dart';
import 'package:weather_forecast/feature/home/data/data_source/weathre_remote_datasource.dart';
import 'package:weather_forecast/feature/home/data/repository/base_repository.dart';
import 'package:weather_forecast/feature/home/domain/entities/weather.dart';

class WeatherRepository extends BaseRepository {
  final BaseWeatherRemoteDataSource baseWeatherRemoteDataSource;
  WeatherRepository({
    required this.baseWeatherRemoteDataSource,
  });
  @override
  Future<Either<Failure, Weather>> getWeather({String city = 'Cairo'}) async{
    final result =await baseWeatherRemoteDataSource.getWeather(city: city);
    try {
      // print('result repository is $result');
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }
}
