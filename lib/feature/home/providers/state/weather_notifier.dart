import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forecast/core/error/failure.dart';
import 'package:weather_forecast/feature/home/domain/entities/weather.dart';
import 'package:weather_forecast/feature/home/domain/usecases/weather_usecase.dart';

class WeatherNotifier extends StateNotifier<AsyncValue<Weather>> {
  WeatherNotifier(this.useCase) : super(const AsyncValue.loading());
  final WeatherUseCase useCase;
  getWeatherByCity({String city = 'cairo'}) async {
    final Either<Failure, Weather> weatherOrFailure =
        await useCase(parameters: city);
    weatherOrFailure.fold(
        (l) => state =
            AsyncValue.error(ServerFailure(l.message), StackTrace.current),
        (r) => state = AsyncValue.data(r));
  }
}
