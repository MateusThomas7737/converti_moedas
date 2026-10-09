// grafico.dart — Responsável: Mateus Thomas
import 'package:flutter/material.dart';

class GraficoScreen extends StatelessWidget {
  const GraficoScreen({super.key, required this.moeda});

  final String moeda;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfico $moeda'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Text(
              'Variação dos últimos 7 dias',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            // Placeholder visual — só para mostrar que a tela existe
            Center(
              child: Icon(Icons.show_chart, size: 120, color: Colors.green),
            ),
            SizedBox(height: 24),
            Text(
              'O gráfico será implementado na próxima etapa.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}