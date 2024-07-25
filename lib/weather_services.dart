import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/model/location_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/widgets/list_widget_homepage.dart';
import 'widgets/hourly_horizontal_widget.dart';

class WeatherServices {
  static const _apiKeyOpenWeather = '13fe2785abfbf31611724ce3821a0ba8';
  static const _forecastURL = 'https://api.openweathermap.org/data/2.5/forecast';
  static const _geoURL = 'http://api.openweathermap.org/geo/1.0/direct';

  List<WeatherForecast> _allWeatherForecasts = [];
  List<HomePageListWidget> _weatherWidgetList = [];
  List<HourlyHorizontalWidget> _horizontalWidgetList = [];
  late WeatherForecast _todaysWeather;
  String _weatherLocation = '';


  // <<-- Fetches and processes weather data from OpenWeather's 5-day, 3-hour forecast. -->>
  // <<-- If a location is provided, it fetches data for that location, otherwise it uses the current location. -->>

  Future<void> fetchWeatherData([selectedLocation]) async {
    final Map<String, WeatherForecast> forecastByDayMap = {};
    List<WeatherForecast> forecastList = [];
    WeatherModel weather;

    try {
      if (selectedLocation != null) {
        LocationModel location = await getSearchedLocationData(selectedLocation);
        weather = await getWeatherData(location.latitude, location.longitude);
      } else {
        Position position = await getCurrentLocation();
        weather = await getWeatherData(position.latitude, position.longitude);
      }
      
      for (var forecast in weather.forecasts) {
        // For Forecast Page: Adds all forecasts
        forecastList.add(forecast);
        _allWeatherForecasts = forecastList;

        // For the HomePage: For each hourly forecast, organizes them by day and 
        // keeps only the forecast with the highest temperature for each day.
        String day = DateFormat('EEEE').format(forecast.dateTime).toString();
        if (!forecastByDayMap.containsKey(day) || forecast.temperature > forecastByDayMap[day]!.temperature) {
          forecastByDayMap[day] = forecast;
        }
      }

      await formatAndSetData(forecastByDayMap, weather);  
    } catch (e) {
      debugPrint('\x1B[31m Error fetching weather data: $e \x1B[0m');
    }
  }


  // <<-- FORMATS AND SETS THE WEATHER DATA FOR THE APP -->>

  Future<void> formatAndSetData(Map<String, WeatherForecast> forecastMap, WeatherModel weather) async {
    List<WeatherForecast> list = [];

    // Set todays weather forecast (homepage widget) and the fetches city and country name
    _todaysWeather = forecastMap.entries.first.value;
    _weatherLocation = '${weather.city}, ${weather.country}';

    // Set Weather Widgets for each day
    _weatherWidgetList = forecastMap.entries
          .map((entry) => HomePageListWidget(weatherInfo: entry.value, day: entry.key,))
          .toList();

    // Create and set list for the horizontal hourly widgets
    for (var forecast in _allWeatherForecasts) {
      if (forecast.dateTime.day == DateTime.now().day || forecast.dateTime.day == DateTime.now().day + 1 ) {
        list.add(forecast);
      }
    }

    _horizontalWidgetList = list.map((element) {
      return HourlyHorizontalWidget(forecast: element);
    }).toList();

  }


  // <<-- FETCHES AND RETURNS DEVICE LOCATION -->>

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      debugPrint('\x1B[31m Permission Denied! \x1B[0m');
      return Future.error('Location services are disabled');

    } else if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) { 
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    return Future.error('Location permission not granted');
  }


  // <<-- RETURNS WEATHER DATA MODEL FOR DEVICE LOCATION -->> 

  // TODO:
  // refactor below methods?
  Future<WeatherModel> getWeatherData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse('$_forecastURL?lat=$latitude&lon=$longitude&appid=$_apiKeyOpenWeather&units=metric'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      WeatherModel mainModel = WeatherModel.fromJson(decodedResponse);

      return mainModel;
    } else {
      throw Exception('Failed to load JSON data');
    }
  }


  // <<-- RETURNS LOCATION DATA BASED ON SEARCH INPUT -->>

  Future<LocationModel> getSearchedLocationData(String city, [country]) async {
    final response = await http.get(Uri.parse('$_geoURL?q=$city&limit=1&appid=$_apiKeyOpenWeather'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      LocationModel location = LocationModel.fromJson(decodedResponse[0]);

      return location;
    } else {
      debugPrint('EMPTY INPUT or json load error, CODE: ${response.statusCode}');
      throw Exception('Failed to load JSON data');
    }
  }

  // <<-- FETCHES AND RETURNS LOCATION MODEL, FOR THE AUTOCOMPLETE DROP DOWN LIST -->>

  Future<List<LocationModel>> fetchAutocompleteLocations(String city) async {
    int limit = 4; // limit on autocomplete options to be displayed
    final response = await http.get(Uri.parse('$_geoURL?q=$city&limit=$limit&appid=$_apiKeyOpenWeather'));

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse.map((json) => LocationModel.fromJson(json)).toList();

    } else {
      debugPrint('\x1B[31m EMPTY or JSON LOAD ERROR, CODE: ${response.statusCode} \x1B[0m');
      return List<LocationModel>.empty();
    }
  }


  //////// GETTERS ////////

  String getWeatherCityAndCountry() {
    return _weatherLocation;
  }

  WeatherForecast getTodaysWeather() {
    return _todaysWeather;
  }

  List<HomePageListWidget> getWeatherWidgetList() {
    return _weatherWidgetList;
  }

  List<WeatherForecast> getAllWeatherForecasts() {
    return _allWeatherForecasts;
  }

  List<HourlyHorizontalWidget> getHorizontalWidgets() {
    return _horizontalWidgetList;
  }

}