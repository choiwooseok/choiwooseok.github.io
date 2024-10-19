import 'package:flutter/material.dart';

import 'presentation/pages/json_formatter.dart';
import 'presentation/pages/lotto_number_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wooseok Choi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LottoNumberGeneratorPage(),
      routes: {
        '/lotto_number_generator': (context) {
          return const LottoNumberGeneratorPage();
        },
        '/json_formatter': (context) {
          return const JsonFormatter();
        },
      },
    );
  }
}
