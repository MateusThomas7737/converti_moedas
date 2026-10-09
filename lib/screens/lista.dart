// lista.dart — Responsável: Paulo Vitor Martins de Castro
import 'package:flutter/material.dart';
import 'detalhe.dart';
import 'favoritos.dart';
import 'grafico.dart';

class ListaScreen extends StatelessWidget {
  const ListaScreen({super.key, required this.moeda});

  final String moeda;

  final List<Map<String, dynamic>> historico = const [
    {'data': '01/10', 'preco': 5.42, 'variacao': 0.00},
    {'data': '02/10', 'preco': 5.38, 'variacao': -0.74},
    {'data': '03/10', 'preco': 5.45, 'variacao': 0.55},
    {'data': '04/10', 'preco': 5.50, 'variacao': 1.48},
    {'data': '05/10', 'preco': 5.47, 'variacao': 0.92},
    {'data': '06/10', 'preco': 5.39, 'variacao': -0.55},
    {'data': '07/10', 'preco': 5.41, 'variacao': -0.18},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico $moeda'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GraficoScreen(moeda: moeda),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritosScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: historico.length,
        itemBuilder: (context, index) {
          final dia = historico[index];
          final variacao = dia['variacao'] as double;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text('${dia['data']}'),
              subtitle: Text(dia['preco'].toStringAsFixed(2)),
              trailing: Text(
                '${variacao >= 0 ? '+' : ''}${variacao.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: variacao >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalheScreen(
                      moeda: moeda,
                      data: dia['data'],
                      preco: dia['preco'],
                      variacao: variacao,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}