import 'package:flutter/material.dart';

class CharactersSearch extends SearchDelegate<String> {
  final List<String> characters = <String>['IRONMAN', 'HULK', 'DEADPOOL', 'THOR'];
  final List images = [
    'assets/images/ironman.jpg',
    'assets/images/hulk.jpg',
    "assets/images/deadp.jpg",
    'assets/images/logan.jpg',
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
  Widget buildResults(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_pin_outlined,
            size: 120,
            color: Colors.black,
          ),
          Center(
            child: Text(
              query,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? characters
        : characters.where((character) {
            final characterLower = character.toLowerCase();
            final queryLower = query.toLowerCase();

            return characterLower.startsWith(queryLower);
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
            leading: CircleAvatar(
              backgroundImage: AssetImage(CharactersSearch().images[index]),
            ),
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
