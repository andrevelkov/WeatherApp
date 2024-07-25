
import 'package:flutter/foundation.dart';
import 'package:weather_app/model/location_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/weather_services.dart';
import 'package:weather_app/widgets/list_widget_forecasts.dart';
import 'package:weather_app/widgets/list_widget_homepage.dart';
import 'package:weather_app/widgets/hourly_horizontal_widget.dart';


class WeatherController extends ChangeNotifier { // Provider Package
  final WeatherServices _weatherServices;

  WeatherController(this._weatherServices);

  Future<void> fetchWeatherData(String? location) async {
    await _weatherServices.fetchWeatherData(location);
    notifyListeners();
    // debugPrint('Notified');
  }

  // City and Country for fetched weather location
  String get location => _weatherServices.getWeatherCityAndCountry();

  // Home Page
  WeatherForecast get todaysForecast => _weatherServices.getTodaysWeather();
  List<HomePageListWidget> get weatherWidgetList => _weatherServices.getWeatherWidgetList();
  List<HourlyHorizontalWidget> get horizontalWidgetList => _weatherServices.getHorizontalWidgets();
  
  // Forecast Page
  List<ForecastsWeatherWidget> get forecastsWidgetList => _weatherServices.getAllWeatherForecasts()
      .map((item) => ForecastsWeatherWidget(weatherInfo: item)).toList();

  // Autocomplete Locations
  Future<List<LocationModel>> fetchAutocompleteLocations(String city) {
    return _weatherServices.fetchAutocompleteLocations(city);
  }
  
}
