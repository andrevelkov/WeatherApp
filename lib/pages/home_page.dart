
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/weather_controller.dart';
import 'package:weather_app/widgets/autocomplete_widget.dart';
import 'package:weather_app/widgets/hourly_horizontal_widget.dart';
import 'package:weather_app/widgets/todayweather_widget.dart';
import 'package:weather_app/widgets/list_widget_homepage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;
  final TextEditingController textEditingController = TextEditingController();
  List<HomePageListWidget> _weatherWidgetList = [];
  List<HourlyHorizontalWidget> _horizontalWidgetList = [];
  String? _weatherLocation;
  bool _isLoading = true;  // loading the page
  bool _isVisible = false; // search button
  
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  void refreshPage() {
    _fetchWeatherData();
  }

  void _fetchWeatherData({String? location}) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      await context.read<WeatherController>().fetchWeatherData(location);

      setState(() {
        _weatherLocation = context.read<WeatherController>().location;
        _weatherWidgetList = context.read<WeatherController>().weatherWidgetList;
        _horizontalWidgetList = context.read<WeatherController>().horizontalWidgetList;

        _isLoading = false;
      });

    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather data, within homepage: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _searchIconPress() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }


  @override
  Widget build (BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin, which saves state of loaded page
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
      
        child: _isLoading
      
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Loading Weather Data...', 
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ],
              ),
            )
      
          : Column(
            children: [

              ///// TOP BAR /////
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.14,
                child: LayoutBuilder(
                  builder:(BuildContext context, BoxConstraints constraints) {

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                  
                        ///// Search Icon Button /////
                        Row(
                          children: [

                            IconButton(
                              onPressed: _searchIconPress,
                              icon: const Icon(
                                Icons.search_rounded,
                                color: Colors.white60,
                              ),
                            ),
                                              
                            ///// Search Text Field /////
                            if (_isVisible)
                              SizedBox(
                                height: constraints.maxHeight * 0.6,
                                width: constraints.maxWidth * 0.765,

                                child: AutocompleteWidget(
                                  searchIconPress: _searchIconPress,
                                  fetchWeatherData: _fetchWeatherData,
                                ),
                              ),
                          ],
                        ),
                    
                        ///// Fetch/Refresh Current Location Button /////
                        IconButton(
                          onPressed: _fetchWeatherData,
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white60,
                          ),
                        ),
                    
                      ]
                    );
      
                  },
                ),
              ),
      
              ///// CITY TEXT /////
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _weatherLocation!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
          
              ///// TODAYS WEATHER, CENTER WEATHER BOX /////
              TodayWeatherWidget(todaysWeather: context.read<WeatherController>().todaysForecast),

              // DIVIDER LINE //
              const Divider(
                height: 40,
                color: Colors.black54,
                indent: 25,
                endIndent: 25,
              ),

              ///// HOURLY FORECAST FOR CURRENT DAY /////
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.1,
              
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _horizontalWidgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _horizontalWidgetList[index];
                    
                  },
                ),
              ),
          
              ///// 5 DAY FORECAST LIST WIDGET, BY DAY /////
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    itemCount: _weatherWidgetList.length - 1,
                    itemBuilder: (BuildContext context, int index) {
                      return _weatherWidgetList[index + 1];
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
