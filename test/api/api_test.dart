import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/feature/home/data/data_source/weather_remote_datasource.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  WeatherRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = WeatherRemoteDataSource(client: mockHttpClient);
  });

  group('getWeather', () {
    test(
      'should perform a GET request on a URL with the city and API key',
      () async {
        // arrange
        when(mockHttpClient.get(any))
            .thenAnswer((_) async => http.Response('', 200));

        // act
        dataSource.getWeather(city: 'test_city');

        // assert
        verify(mockHttpClient.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=test_city&APPID=your_api_key')));
      },
    );

    test(
      'should throw an exception when the client throws an error',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenThrow(Exception('Network Error'));

        // act
        final call = dataSource.getWeather;

        // assert
        expect(() => call(city: 'test_city'), throwsException);
      },
    );

    test(
      'should rethrow the original exception when the client throws an error',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenThrow(Exception('Network Error'));

        // act
        final call = dataSource.getWeather;

        // assert
        expect(() => call(city: 'test_city'), throwsA(isA<Exception>()));
      },
    );

    test(
      'should rethrow the original exception when the client throws a TimeoutException',
      () async {
        // arrange
        when(mockHttpClient.get(any))
            .thenThrow(TimeoutException('Timeout Error'));

        // act
        final call = dataSource.getWeather;

        // assert
        expect(() => call(city: 'test_city'), throwsA(isA<TimeoutException>()));
      },
    );

    test(
      'should rethrow the original exception when the client throws a SocketException',
      () async {
        // arrange
        when(mockHttpClient.get(any))
            .thenThrow(const SocketException('Socket Error'));

        // act
        final call = dataSource.getWeather;

        // assert
        expect(() => call(city: 'test_city'), throwsA(isA<SocketException>()));
      },
    );
  });
}
