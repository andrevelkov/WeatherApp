import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class TodayWeatherWidget extends StatelessWidget {
  final WeatherForecast todaysWeather;

  const TodayWeatherWidget({
    super.key,
    required this.todaysWeather,
    });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width *  0.8,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:  Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(6),
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerWidth = constraints.maxWidth;
          final containerHeight = constraints.maxHeight;
  
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
          
                  SizedBox(
                      height: containerHeight * 0.5,
                      width: containerWidth * 0.4,
                      child: Image.network(
                        'https://openweathermap.org/img/wn/${todaysWeather.icon}@4x.png',
                        fit: BoxFit.fitHeight,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
            
                  ///// TEXT AND TEMPERATURE /////
                  Column(
                    children: [
                      Text(
                        '${todaysWeather.detailedDescription[0].toUpperCase()}${todaysWeather.detailedDescription.substring(1)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                              
                      Text(
                        '${todaysWeather.temperature.toStringAsFixed(0)}\u00B0',
                        style: const TextStyle(
                          fontSize: 55,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 4,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                              
                    ],
                  ),
                ],
          
              ),
          
              ///// WEATHER DETAILS INFO /////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              
                  /// PRECIPITATION /// 
                  Column(
                    children: [
                      const BoxedIcon(
                        WeatherIcons.umbrella,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        '${((todaysWeather.rain) * 100).toInt().toString()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'Precipitation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
              
                  /// HUMIDITY ///
                  Column(
                    children: [
                      const BoxedIcon(
                        WeatherIcons.raindrop,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        '${todaysWeather.humidity.toString()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'Humidity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
              
                  /// WIND SPEED ///
                  Column(
                    children: [
                      const BoxedIcon(
                        WeatherIcons.strong_wind,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        '${(todaysWeather.wind)} m/s',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'Wind Speed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
              
                ],
              ),
            ],
          
          );
        },
      ),
    );

  }
}