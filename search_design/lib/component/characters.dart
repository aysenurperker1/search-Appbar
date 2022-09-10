import 'package:flutter/material.dart';

class CharactersSearch extends SearchDelegate<String> {
  final List<String> characters = <String>['IRONMAN', 'HULK', 'DEADPOOL', 'THOR'];
  final List images = [
    'assets/images/ironman.jpg',
    'assets/images/hulk.jpg',
    "assets/images/deadp.jpg",
    'assets/images/logan.jpg',
  ];

  final recentCities = [
    'Berlin',
    'Munich',
    'London',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, "bos");
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, "bos"),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_city, size: 120),
            const SizedBox(height: 48),
            Text(
              query,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : characters.where((city) {
            final cityLower = city.toLowerCase();
            final queryLower = query.toLowerCase();

            return cityLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              showResults(context);
            },
            leading: const Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
