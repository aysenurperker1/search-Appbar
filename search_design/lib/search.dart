import 'package:flutter/material.dart';
import '/main.dart';
import 'component/cities.dart';

class LocalSearchAppBarPage extends StatelessWidget {
  const LocalSearchAppBarPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            MyApp.title,
            style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black87),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black87),
              onPressed: () async {
                showSearch(context: context, delegate: CharactersSearch());
              },
            )
          ],
        ),
        body: Container(
          color: Colors.grey[50],
          child: Center(
            child: ListView.builder(
              itemCount: CharactersSearch().characters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(CharactersSearch().images[index]),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: CharactersSearch().characters[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
