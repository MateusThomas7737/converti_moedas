// detalhe.dart — Responsável: Ana Carolina Rodrigues de Almeida César Alves
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cotacao_provider.dart';

import '../models/cotacao.dart';

class DetalheScreen extends StatelessWidget {
  const DetalheScreen({
    super.key,
    required this.moeda,
    required this.cotacao,
    required this.historico,
  });

  final String moeda;
  final Cotacao cotacao;
  final List<Cotacao> historico;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CotacaoProvider>();
    final favoritada = provider.estaFavoritada(moeda);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('$moeda/BRL'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Text(
              'Cotação de ${cotacao.dataFormatada}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${cotacao.preco.toStringAsFixed(4)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Variação: '
              '${cotacao.variacao >= 0 ? '+' : ''}'
              '${cotacao.variacao.toStringAsFixed(2)}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: cotacao.variacao >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Variação dos últimos 7 dias',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                title: const Text('Preço Máximo'),
                trailing: Text('R\$ ${cotacao.maxima.toStringAsFixed(4)}'),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Preço Mínimo'),
                trailing: Text('R\$ ${cotacao.minima.toStringAsFixed(4)}'),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () async {
                await provider.alternarFavorito(moeda);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      favoritada
                          ? '$moeda removida dos favoritos!'
                          : '$moeda adicionada aos favoritos!',
                    ),
                  ),
                );
              },
              child: Text(favoritada ? 'Remover dos favoritos' : 'Favoritar'),
            ),
          ],
        ),
      ),
    );
  }
}
