import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forecast/feature/home/data/data_source/weather_remote_datasource.dart';
import 'package:weather_forecast/feature/home/domain/repository/weather_repository.dart';
import 'package:weather_forecast/feature/home/domain/usecases/weather_usecase.dart';
import 'package:weather_forecast/feature/home/providers/state/weather_notifier.dart';

import '../domain/entities/weather.dart';

//first provider to be injected
final weatherDataSourceProvider =
    Provider<WeatherRemoteDataSource>((ref) => WeatherRemoteDataSource());

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final datasource = ref.read(weatherDataSourceProvider);
  return WeatherRepository(baseWeatherRemoteDataSource: datasource);
});

final weatherUseCaseProvider = Provider<WeatherUseCase>((ref) {
  final repo = ref.read(weatherRepositoryProvider);
  return WeatherUseCase(baseRepository: repo);
});

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<Weather>>((ref) {
  final useCase = ref.read(weatherUseCaseProvider);
  return WeatherNotifier(useCase);
});
