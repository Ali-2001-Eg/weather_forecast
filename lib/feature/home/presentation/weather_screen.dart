import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_forecast/core/colors.dart';
import 'package:weather_forecast/core/enums/weather_condition.dart';
import 'package:weather_forecast/core/functions/text_styles.dart';
import 'package:weather_forecast/feature/home/domain/entities/weather.dart';
import 'package:weather_forecast/feature/home/providers/weather_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/functions/gradient_background.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void didChangeDependencies() {
    ref.read(weatherNotifierProvider.notifier).getWeatherByCity(city: 'Cairo');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherNotifierProvider);
    // WeatherEnum currentCondition = WeatherEnum.sunny;
    return Scaffold(
        body: weatherState.when(data: (data) {
      WeatherEnum condition =
          getWeatherConditionFromDescription(weatherState.value!.description);
      LinearGradient gradient = getGradientForWeatherCondition(condition);
      return Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.antiAlias,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height,
                      minWidth: double.infinity),
                  decoration: BoxDecoration(
                    gradient: gradient,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 9,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            _currentCityName(ref),
                            //temperature and icon
                            _currTemp(weatherState),
                            //max and min
                            _maxMin(weatherState),
                            5.verticalSpace,
                            //weather condition
                            _weatherCondition(weatherState),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 15,
                      ),
                      //comfort level
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Comfort Level'.toUpperCase(),
                            style: myStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      5.verticalSpace,
                      _humidityBuilder(weatherState),
                      15.verticalSpace,
                      _pressureBuilder(weatherState),
                      15.verticalSpace,
                      _windBuilder(weatherState),
                      15.verticalSpace,
                    ],
                  ),
                )
              ],
            ),
          ),
          _searchButton(),
        ],
      );
    }, error: (error, stack) {
      return Scaffold(
        body: Center(
            child: Text(
          error.toString(),
          style: myStyle(color: Colors.red),
        )),
      );
    }, loading: () {
      return Scaffold(
        body: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 150.0,
                        color: Colors.white,
                      ),
                    )),
          ),
        ),
      );
    }));
  }

  Container _humidityBuilder(AsyncValue<Weather> weatherState) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Humidity',
            style: myStyle(),
          ),
          CircularPercentIndicator(
            radius: 50,
            center: Text(
              '${weatherState.value!.humidity.toString()}%',
              style: myStyle(),
            ),
            animation: true,
            curve: Curves.ease,
            percent: weatherState.value!.humidity.toDouble() / 100,
            animationDuration: 1200,
            arcBackgroundColor: Colors.white,
            arcType: ArcType.FULL,
            footer: Text(
              '0\t\t\t\t\t\t100',
              style: myStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  Container _pressureBuilder(AsyncValue<Weather> weatherState) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0)
                .add(const EdgeInsets.symmetric(horizontal: 40)),
            child: Text(
              'Pressure',
              style: myStyle(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: 5,
                child: LinearProgressIndicator(
                  value: weatherState.value!.pressure /
                      1100, // assuming max pressure is 1100 hPa
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.red,
                ),
              ),
              Text(
                '${weatherState.value!.pressure} hPa',
                style: myStyle(fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column _windBuilder(AsyncValue<Weather> weatherState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'wind'.toUpperCase(),
              style: myStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              LottieBuilder.asset(
                'assets/json/wind.json',
                height: 100.h,
                // width: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Direction : ${_getCompassDirection(weatherState.value!.windDirection.toDouble())}',
                    style: myStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Speed : ${weatherState.value!.windSpeed} km/h',
                    style: myStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  String _getCompassDirection(double degree) {
    if (degree >= 337.5 || degree < 22.5) {
      return 'North';
    } else if (degree >= 22.5 && degree < 67.5) {
      return 'Northeast';
    } else if (degree >= 67.5 && degree < 112.5) {
      return 'East';
    } else if (degree >= 112.5 && degree < 157.5) {
      return 'Southeast';
    } else if (degree >= 157.5 && degree < 202.5) {
      return 'South';
    } else if (degree >= 202.5 && degree < 247.5) {
      return 'Southwest';
    } else if (degree >= 247.5 && degree < 292.5) {
      return 'West';
    } else if (degree >= 292.5 && degree < 337.5) {
      return 'Northwest';
    } else {
      return 'Unknown';
    }
  }

  Positioned _searchButton() {
    return Positioned(
        top: 35.h,
        right: 20.w,
        child: IconButton(
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ));
  }

  Text _weatherCondition(weatherState) {
    return Text(
      _getDescription(weatherState),
      style: myStyle(),
    );
  }

  Text _maxMin(weatherState) {
    return Text(
      _getMinMax(weatherState),
      style: myStyle(fontSize: 13),
    );
  }

  Row _currTemp(AsyncValue<Weather> weatherState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _getTemp(weatherState),
                style: myStyle(fontSize: 40),
              ),
              //to display Celsius symbol in top of the degree
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(2, -10),
                  child: Text(
                    '\u00B0',
                    style: myStyle(fontSize: 20).copyWith(),
                  ),
                ),
              ),
              TextSpan(
                text: 'C',
                style: myStyle(fontSize: 20),
              ),
            ],
            // style: myStyle(fontSize: 50),
          ),
        ),
        CachedNetworkImage(
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: _getIcon(weatherState),
        ),
      ],
    );
  }

  String _getTemp(AsyncValue<Weather> weatherState) {
    return weatherState.when(
      loading: () => '',
      error: (error, stack) {
        return '';
      },
      data: (weather) => _kelvinToCelsius(weather).toStringAsFixed(1),
    );
  }

  String _getDescription(AsyncValue<Weather> weatherState) {
    return weatherState.when(
      loading: () => '',
      error: (error, stack) {
        return '';
      },
      data: (weather) => weather.description,
    );
  }

  double _kelvinToCelsius(Weather weather) => weather.temp - 273.15;

  String _getIcon(AsyncValue<Weather> weatherState) {
    return weatherState.when(
      loading: () => '',
      error: (error, stack) {
        return '';
      },
      data: (weather) =>
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
    );
  }

  String _getMinMax(AsyncValue<Weather> weatherState) {
    return weatherState.when(
      loading: () => '',
      error: (error, stack) {
        return '';
      },
      data: (weather) => weather.minMax,
    );
  }

  Row _currentCityName(WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Cairo',
          style: myStyle(),
          maxLines: 2,
        ),
        5.horizontalSpace,
        const Icon(
          Icons.location_on,
          color: Colors.white,
          size: 20,
        )
      ],
    );
  }
}
