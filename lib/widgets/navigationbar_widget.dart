
import 'package:flutter/material.dart';
import 'package:weather_app/pages/about_page.dart';
import 'package:weather_app/main.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidget();
}

class _NavigationBarWidget extends State<NavigationBarWidget> {
  int _selectedIndex = 0;

  void _onIconPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    }

  }

  @override
  Widget build (BuildContext context) {

    return BottomAppBar(
      elevation: 0,
      height: 45,
      color: const Color.fromARGB(255, 64, 20, 85),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
        children: [
      
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: _selectedIndex == 1 ? null : () => _onIconPressed(1),
            icon: const Icon(
              Icons.bar_chart_rounded,
              color: Colors.white,
            ),
          ),
      
          IconButton(
            isSelected: true,
            padding: EdgeInsets.zero,
            onPressed: _selectedIndex == 0 ? null : () => _onIconPressed(0),
            selectedIcon: const Icon(
              Icons.home_filled,
              color: Colors.white,
              
            ),
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
          ),
      
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: _selectedIndex == 2 ? null : () => _onIconPressed(2),
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
          ),
      
        ],
      ),

    );
    
  }
}
