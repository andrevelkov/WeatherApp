
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';

class ForecastsWeatherWidget extends StatelessWidget {
  final WeatherForecast weatherInfo;

  const ForecastsWeatherWidget({
    super.key,
    required this.weatherInfo,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(1),

      child: ListTile(
        contentPadding: EdgeInsets.zero,

        leading: Container(
          padding: const EdgeInsets.only(left: 15),
          width: 135,

          child: Text(
            DateFormat('EEE, MMM d - HH:mm').format(weatherInfo.dateTime).toString(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.5, 0.5),
                  blurRadius: 1,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),

        title: Center(
          child: Row(
            children: [
          
              // WEATHER ICON //
               SizedBox(
                height: 50,
                width: 50,
                child: 
                Image.network('https://openweathermap.org/img/wn/${weatherInfo.icon}@4x.png',
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
                    
              // WEATHER DESCRIPTION //
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 110,
                  child: Text(
                    '${weatherInfo.detailedDescription[0].toUpperCase()}${weatherInfo.detailedDescription.substring(1)}',
                    style: const TextStyle(
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                      color: Color.fromARGB(235, 245, 243, 243),
                      shadows: <Shadow> [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0.5, 0.5),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          
          ),
        ),

        // WEATHER TEMPERATURE //
        trailing: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            '${weatherInfo.temperature.toStringAsFixed(0)} \u00B0C',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
  
}