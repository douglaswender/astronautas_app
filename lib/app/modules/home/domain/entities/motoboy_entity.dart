class MotoboyEntity {
  final String documento;
  final String nome;
  final String telefone;
  final String tipoDocumento;
  final bool? trabalhando;
  final String placa;
  MotoboyEntity({
    required this.documento,
    required this.nome,
    required this.telefone,
    required this.tipoDocumento,
    this.trabalhando,
    required this.placa,
  });
}
