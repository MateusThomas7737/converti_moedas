// cotacao.dart — Responsável: Ana Carolina Rodrigues de Almeida César Alves
class Cotacao {
  final double preco;
  final double maxima;
  final double minima;
  final double variacao;
  final DateTime data;

  Cotacao({
    required this.preco,
    required this.maxima,
    required this.minima,
    required this.variacao,
    required this.data,
  });

  factory Cotacao.fromJson(Map<String, dynamic> json) {
    DateTime data;

    if (json['create_date'] != null) {
      data = DateTime.parse(json['create_date'].toString());
    } else {
      final timestamp = int.parse(json['timestamp'].toString());
      data = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }

    return Cotacao(
      preco: double.parse(json['bid'].toString()),
      maxima: double.parse(json['high'].toString()),
      minima: double.parse(json['low'].toString()),
      variacao: double.parse(json['pctChange'].toString()),
      data: data,
    );
  }

  String get dataFormatada =>
      '${data.day.toString().padLeft(2, '0')}/'
      '${data.month.toString().padLeft(2, '0')}';
}
