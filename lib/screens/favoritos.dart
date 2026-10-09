// favoritos.dart — Responsável: Equipe Moedas
import 'package:flutter/material.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  final List<Map<String, String>> favoritos = const [
    {'codigo': 'USD', 'nome': 'Dólar Americano'},
    {'codigo': 'EUR', 'nome': 'Euro'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: favoritos.isEmpty
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
                    title: Text(fav['codigo']!),
                    subtitle: Text(fav['nome']!),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
    );
  }
}