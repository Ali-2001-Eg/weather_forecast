enum WeatherEnum {
  sunny('clear sky'),
  fewClouds('few clouds'),
  scatteredClouds('scattered clouds'),
  brokenClouds('broken clouds'),
  showerRain('shower rain'),
  rainy('rain'),
  thunderstorm('thunderstorm'),
  snowy('snow'),
  mist('mist'),
  others('others');

  final String condition;
  const WeatherEnum(this.condition);
}
