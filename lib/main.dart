import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/forecasts_page.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/about_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/weather_controller.dart';
import 'package:weather_app/weather_services.dart';

// Weather App that fetches data from OpenWeather's 5-day, 3-hour forecast API.
// Displays weather data for the device's current location or a user-searched location.

void main() {
  final weatherServices = WeatherServices();

  runApp(
    ChangeNotifierProvider( // Provider package, creates a global access point for the WeatherController
      create: (_) => WeatherController(weatherServices),
      
      child:  const MyApp(),
    ),
  );
}

// TODO:

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.redHatDisplayTextTheme(), 
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<void> _weatherDataFuture;
  late PageController _pageController;
  int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _weatherDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await context.read()<WeatherController>().fetchWeatherData();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather data, *In main: $e');
      }
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.1, 0.6, 0.9],
          colors: [
            Color.fromARGB(255, 110, 192, 233),
            Color.fromARGB(255, 18, 112, 158),
            Color.fromARGB(255, 13, 71, 100),
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
      
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          backgroundColor: const Color.fromARGB(255, 13, 71, 100),
          elevation: 0,
        ),
      
        body: 
      
        FutureBuilder<void>(
          future: _weatherDataFuture,
          builder: (context, snapshot) {
      
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              );
      
            } else {
      
              // Once weather data is loaded, show the PageView
              return PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
      
                children: const [

                  ForecastPage(),
                  HomePage(),
                  AboutPage(),
      
                ],
              );
            }
          },
        ),
      
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 110, 192, 233),
          height: 40,
          onDestinationSelected: _onNavItemTapped,
          indicatorColor: Colors.transparent,
          selectedIndex: _currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      
          destinations: const [
            
            NavigationDestination(
              selectedIcon: Icon(
                Icons.bar_chart_rounded,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.bar_chart_outlined,
                color: Colors.white54,
              ),
              label: 'Forecast',
            ),
      
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white54,
              ), 
              label: 'Home',
            ),
      
            NavigationDestination(
              selectedIcon: Icon(
                Icons.info_rounded,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.white54,
              ), 
              label: 'About',
            ),
      
          ],
      
        ),
      ),
    );
  }
}


