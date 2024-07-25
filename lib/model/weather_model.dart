
class WeatherModel {
  final String city;
  final String country;
  final int sunrise;
  final int sunset;
  final List<WeatherForecast> forecasts;

  WeatherModel({
    required this.city,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.forecasts,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {

    List<WeatherForecast> forecastList = (json['list'] as List)
      .map((item) => WeatherForecast.fromJson(item)).toList();
    
    return WeatherModel(
      city: json['city']['name'],
      country: json['city']['country'],
      sunrise: json['city']['sunrise'], 
      sunset: json['city']['sunset'],
      forecasts: forecastList,
    );
  }
}

class WeatherForecast {
  final DateTime dateTime;
  final double temperature;
  final String weather;
  final String detailedDescription;
  final int humidity;
  final double wind;
  final double rain;
  final String icon;

  WeatherForecast({
    required this.dateTime,
    required this.temperature,
    required this.weather,
    required this.detailedDescription,
    required this.humidity, 
    required this.wind, 
    required this.rain,
    required this.icon,
    });
  
  factory WeatherForecast.fromJson(Map<String, dynamic> json) {

    return WeatherForecast(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: (json['main']['temp'] as num).toDouble(),
      weather: json['weather'][0]['main'],
      detailedDescription: json['weather'][0]['description'],
      humidity: json['main']['humidity'],                              // percentage
      wind: (json['wind']['speed'] as num).toDouble(),                 // m/s
      rain: (json['pop'] as num).toDouble(),                           // 0 = 0 %, 1 = 100 %
      icon: json['weather'][0]['icon'],
    );
  }
}