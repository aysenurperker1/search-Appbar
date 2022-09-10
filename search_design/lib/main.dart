import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_design/search.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'CITY SEARCH';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            primarySwatch: Colors.deepOrange,
            appBarTheme: const AppBarTheme(centerTitle: true, backgroundColor: Colors.white),
            iconTheme: const IconThemeData(color: Colors.black87)),
        home: const LocalSearchAppBarPage(title: title),
      );
}
