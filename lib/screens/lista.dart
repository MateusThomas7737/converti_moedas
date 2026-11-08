// lista.dart — Responsável: Paulo Vitor Martins de Castro
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detalhe.dart';
import 'favoritos.dart';
import 'grafico.dart';
import '../providers/cotacao_provider.dart';

class ListaScreen extends StatelessWidget {
  const ListaScreen({super.key, required this.moeda});

  final String moeda;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CotacaoProvider>();

    if (provider.moedaCarregada != moeda && !provider.carregando) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CotacaoProvider>().buscar(moeda);
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Histórico $moeda'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () {
              if (provider.cotacoes.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nenhuma cotação disponível.')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GraficoScreen(
                      moeda: moeda,
                      historico: provider.cotacoes,
                    ),
                  ),
                );
              }
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

      body: provider.carregando
          ? const Center(child: CircularProgressIndicator())
          : provider.erro != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.erro!),
                  ElevatedButton(
                    onPressed: () {
                      provider.buscar(moeda);
                    },
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            )
          : provider.cotacoes.isEmpty
          ? const Center(child: Text('Nenhuma cotação encontrada.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.cotacoes.length,
              itemBuilder: (context, index) {
                final dia = provider.cotacoes[index];
                final variacao = dia.variacao;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(dia.dataFormatada),
                    subtitle: Text(dia.preco.toStringAsFixed(4)),
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
                            cotacao: dia,
                            historico: provider.cotacoes,
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
