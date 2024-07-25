import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();  
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,

      child: Padding(
        padding: const EdgeInsets.only(top: 120),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Container(
              width: 360,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(5)
              ),

              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Project Weather',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 320,
                    child: Text(
                      'This is an app that is developed for the course ' 
                      '1DV535 at Linneaus University using Flutter ' 
                      'and the OpenWeatherMap API.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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

                  SizedBox(
                    width: 300,
                    child: Text(
                      'Developed by: André Velkov Janusev ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
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

                ],
              ),
            ),
          ],
          
        ),
      ),
    );
  }

}
