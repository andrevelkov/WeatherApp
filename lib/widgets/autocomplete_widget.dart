
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/location_model.dart';
import 'package:weather_app/weather_controller.dart';

class AutocompleteWidget extends StatelessWidget {
  final VoidCallback searchIconPress;
  final void Function({String? location}) fetchWeatherData;

  const AutocompleteWidget({
    super.key,
    required this.searchIconPress,
    required this.fetchWeatherData,
  });

  // If text field not empty, callback function to fetch data
  void _onTextFieldSubmitted(String location) {
    if (location.isNotEmpty) {
      fetchWeatherData(location: location);
    }

    Future.delayed(const Duration(milliseconds: 350), () {
      searchIconPress();
    });
  }

  // Fetches and returns string list with the fetched locations
  Future<Iterable<String>> autocompleteList(BuildContext context, String? query) async {
    List<LocationModel> options = await context.read<WeatherController>().fetchAutocompleteLocations(query!);
    Iterable<String> locations = options.map((l) => '${l.city}, ${l.state != null ? '${l.state},' : ''} ${l.country}');
    return locations;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(

      optionsBuilder: (TextEditingValue textEditingValue) async {
        Iterable<String> lastOptions = <String>[];
        String query = textEditingValue.text;
        Iterable<String> locations = await autocompleteList(context, textEditingValue.text);

        // If another search happened after this one, throw away these options,
        // use previous options instead and wait for the newer search req to finish
        if (query != textEditingValue.text) {
          return lastOptions;
        }
        lastOptions = locations;
        return locations;
      },

      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return

        TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (value) {
            _onTextFieldSubmitted(value);
          },

          decoration: InputDecoration(
            fillColor: Colors.white.withOpacity(0.3),
            filled: true,

            labelText: 'Search by City',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            
            hintText: 'Halmstad, SE',
            hintStyle: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),


            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),

            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),      
        );
        
      },

      /* onSelected:(option) {
        debugPrint('Selected: $option');
        // weird error when update on selection, app freeze
        // _onTextFieldSubmitted(option);
      }, */

      optionsViewBuilder: (context, onSelected, locations) {
        return Align(
          alignment: Alignment.topLeft,

          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              ),

            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.765,
              height: locations.length * 50,
              
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  String option = locations.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  
}