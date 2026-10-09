// detalhe.dart — Responsável: Ana Carolina Rodrigues de Almeida César
import 'package:flutter/material.dart';

class DetalheScreen extends StatelessWidget {
  const DetalheScreen({
    super.key,
    required this.moeda,
    required this.data,
    required this.preco,
    required this.variacao,
  });

  final String moeda;
  final String data;
  final double preco;
  final double variacao;

  @override
  Widget build(BuildContext context) {
    final precoMax = preco + 0.10;
    final precoMin = preco - 0.08;

    return Scaffold(
      appBar: AppBar(
        title: Text('$moeda — $data'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              preco.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Variação: ${variacao >= 0 ? '+' : ''}${variacao.toStringAsFixed(2)}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: variacao >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                title: const Text('Preço Máximo'),
                trailing: Text(precoMax.toStringAsFixed(2)),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Preço Mínimo'),
                trailing: Text(precoMin.toStringAsFixed(2)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$moeda favoritada! (na próxima etapa)')),
                );
              },
              child: const Text('Favoritar'),
            ),
          ],
        ),
      ),
    );
  }
}