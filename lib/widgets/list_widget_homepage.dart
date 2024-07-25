
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class HomePageListWidget extends StatelessWidget {
  final WeatherForecast weatherInfo;
  final String day;

  const HomePageListWidget({
    super.key,
    required this.weatherInfo,
    required this.day,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.all(1),

      child: ListTile(
        minVerticalPadding: 25,
        contentPadding: EdgeInsets.zero,
        
        leading: Container(
          padding: const EdgeInsets.only(left: 25),
          width: 110,

          child: Text(
            day,
            style: const TextStyle(
              fontSize: 15,
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
          heightFactor: 0.76,
          child: Container(
            height: 60,
            alignment: Alignment.center,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // WEATHER ICON //
                 SizedBox(
                  height: 60,
                  width: 60,
                  child: 
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherInfo.icon}@4x.png',
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
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            // blurRadius: 1,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

            )
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
                  offset: Offset(0.5, 0.5),
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