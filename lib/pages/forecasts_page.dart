import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_controller.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();  
}

class _ForecastPageState extends State<ForecastPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final weatherNotifier = context.watch<WeatherController>();

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,

      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            // Text Box 'Hourly Forecast' //
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                // color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),

              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hourly Forecasts' ,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2, 1),
                          blurRadius: 4.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///// Listed Forecast /////
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),

                child: ListView.builder(
                  itemCount: weatherNotifier.forecastsWidgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return weatherNotifier.forecastsWidgetList[index];
                  },
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }

}
