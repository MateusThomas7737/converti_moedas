// busca.dart — Responsável: Mateus Thomas
import 'package:flutter/material.dart';
import 'lista.dart';

class BuscaScreen extends StatefulWidget {
  const BuscaScreen({super.key});

  @override
  State<BuscaScreen> createState() => _BuscaScreenState();
}

class _BuscaScreenState extends State<BuscaScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _moedaSelecionada;

  final List<Map<String, String>> moedas = const [
    {'codigo': 'USD', 'nome': 'Dólar Americano'},
    {'codigo': 'EUR', 'nome': 'Euro'},
    {'codigo': 'GBP', 'nome': 'Libra Esterlina'},
    {'codigo': 'JPY', 'nome': 'Iene Japonês'},
    {'codigo': 'ARS', 'nome': 'Peso Argentino'},
    {'codigo': 'CAD', 'nome': 'Dólar Canadense'},
  ];

  void _buscar() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ListaScreen(moeda: _moedaSelecionada!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converti Moedas'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Converti Moedas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Veja o histórico de cotações em relação ao Real.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              DropdownButtonFormField<String>(
                value: _moedaSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Selecione a moeda',
                  border: OutlineInputBorder(),
                ),
                items: moedas.map((m) {
                  return DropdownMenuItem<String>(
                    value: m['codigo'],
                    child: Text('${m['codigo']} — ${m['nome']}'),
                  );
                }).toList(),
                onChanged: (valor) {
                  setState(() {
                    _moedaSelecionada = valor;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione uma moeda';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _buscar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Buscar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}