class Failure {
  final dynamic error;
  Failure({
    required this.error,
  });

  @override
  String toString() {
    return "ERRO: ${super.toString()}";
  }
}
