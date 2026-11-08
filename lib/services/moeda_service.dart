// moeda_service.dart — Responsável: Ana Carolina Rodrigues de Almeida César Alves
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cotacao.dart';

class MoedaService {
  Future<List<Cotacao>> buscarCotacoes(String moeda) async {
    final url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/daily/$moeda-BRL/7',
    );

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final List dados = jsonDecode(resposta.body);

      final cotacoes = dados.map((item) {
        return Cotacao.fromJson(item);
      }).toList();

      cotacoes.sort((a, b) => b.data.compareTo(a.data));

      return cotacoes;
    } else {
      throw Exception('Erro ao buscar cotações');
    }
  }
}
