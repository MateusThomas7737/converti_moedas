// grafico.dart — Responsável: Mateus Thomas
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/cotacao.dart';

class GraficoScreen extends StatelessWidget {
  const GraficoScreen({
    super.key,
    required this.moeda,
    required this.historico,
  });

  final String moeda;
  final List<Cotacao> historico;

  @override
  Widget build(BuildContext context) {
    if (historico.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Gráfico $moeda'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Nenhuma cotação disponível para o gráfico.'),
        ),
      );
    }
    final precos = historico.map((dia) => dia.preco).toList();

    final menorPreco = precos.reduce(math.min);
    final maiorPreco = precos.reduce(math.max);

    final limiteInferior = menorPreco < 0.05
        ? 0.0
        : (menorPreco.floor() - 1).toDouble();

    final limiteSuperior = maiorPreco < 0.05
        ? 0.05
        : math.max(3, maiorPreco.ceil() + 1).toDouble();

    final intervaloY = (limiteSuperior - limiteInferior) / 5;

    final pontos = historico.asMap().entries.map((entrada) {
      return FlSpot(entrada.key.toDouble(), entrada.value.preco);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Gráfico $moeda'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Variação dos últimos 7 dias',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: math.max(1, historico.length - 1).toDouble(),
                  minY: limiteInferior.toDouble(),
                  maxY: limiteSuperior.toDouble(),

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: intervaloY,
                  ),

                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 75,
                        interval: intervaloY,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final indice = value.toInt();

                          if (indice < 0 || indice >= historico.length) {
                            return const SizedBox.shrink();
                          }

                          final meio = historico.length ~/ 2;

                          if (indice != 0 &&
                              indice != meio &&
                              indice != historico.length - 1) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              historico[indice].dataFormatada,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: pontos,
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.15),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              'Preço atual: R\$ ${historico.last.preco.toStringAsFixed(4)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            const Text(
              'Valores da cotação em relação ao real (BRL).',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
