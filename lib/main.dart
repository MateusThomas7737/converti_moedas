// main.dart — Responsável: Mateus Thomas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/busca.dart';
import 'providers/cotacao_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CotacaoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Converti Moedas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const BuscaScreen(),
    );
  }
}
