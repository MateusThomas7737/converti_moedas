// favoritos.dart — Responsável: Equipe Moedas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cotacao_provider.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  final Map<String, String> nomesMoedas = const {
    'USD': 'Dólar Americano',
    'EUR': 'Euro',
    'JPY': 'Iene Japonês',
    'GBP': 'Libra Esterlina',
    'ARS': 'Peso Argentino',
    'CLP': 'Peso Chileno',
    'CAD': 'Dólar Canadense',
    'CHF': 'Franco Suíço',
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CotacaoProvider>();
    final favoritos = provider.favoritos;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Favoritos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: !provider.favoritosCarregados
          ? const Center(child: CircularProgressIndicator())
          : favoritos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum favorito ainda',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final fav = favoritos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(fav),
                    subtitle: Text(nomesMoedas[fav] ?? 'Moeda favorita'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        provider.alternarFavorito(fav);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
