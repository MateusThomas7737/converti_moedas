// cotacao_provider.dart — Responsável: Ana Carolina Rodrigues de Almeida César Alves

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cotacao.dart';
import '../services/moeda_service.dart';

class CotacaoProvider extends ChangeNotifier {
  final MoedaService _service = MoedaService();

  List<Cotacao> cotacoes = [];
  List<String> favoritos = [];

  bool favoritosCarregados = false;
  bool carregando = false;
  String? erro;
  String? moedaCarregada;

  CotacaoProvider() {
    carregarFavoritos();
  }

  Future<void> carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();

    favoritos = prefs.getStringList('favoritos') ?? [];

    favoritosCarregados = true;
    notifyListeners();
  }

  bool estaFavoritada(String moeda) {
    return favoritos.contains(moeda);
  }

  Future<void> alternarFavorito(String moeda) async {
    final prefs = await SharedPreferences.getInstance();

    if (favoritos.contains(moeda)) {
      favoritos.remove(moeda);
    } else {
      favoritos.add(moeda);
    }

    await prefs.setStringList('favoritos', favoritos);

    notifyListeners();
  }

  Future<void> buscar(String moeda) async {
    carregando = true;
    erro = null;
    cotacoes = [];
    moedaCarregada = moeda;

    notifyListeners();

    try {
      cotacoes = await _service.buscarCotacoes(moeda);
    } catch (e) {
      erro = 'Não foi possível carregar as cotações. $e';
    }

    carregando = false;
    notifyListeners();
  }
}
