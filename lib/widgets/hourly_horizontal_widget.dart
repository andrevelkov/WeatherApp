
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';

class HourlyHorizontalWidget extends StatelessWidget {
  final WeatherForecast forecast;

  const HourlyHorizontalWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: 60,
          
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(3),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                        
                  Text(
                    DateFormat.Hm().format(forecast.dateTime).toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                        
                  SizedBox(
                    height: 40, width: 40,
                    child:
                    Image.network('https://openweathermap.org/img/wn/${forecast.icon}@4x.png',
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                        
                  Text(
                    '${(forecast.temperature.round())}\u00B0',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                        
                ],
              ),
            ),
          ),
        );

      },
    );
  }
}