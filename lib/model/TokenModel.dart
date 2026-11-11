class TokenModel {
  final String value;

  // Expressão regular estrita: 4 letras minúsculas, hífen, 4 números
  static final RegExp _regex = RegExp(r'^[a-z]{4}-[0-9]{4}$');

  // Construtor privado
  const TokenModel._(this.value);

  // Factory que valida e normaliza o formato antes de criar o objeto
  factory TokenModel(String input) {
    final formatted = input.trim().toLowerCase();

    if (!_regex.hasMatch(formatted)) {
      throw FormatException(
        'Formato de token inválido: "$input". O esperado é aaaa-0000.',
      );
    }

    return TokenModel._(formatted);
  }

  // Construtor seguro que retorna null em vez de lançar erro (útil para formulários)
  static TokenModel? tryParse(String? input) {
    if (input == null) return null;
    try {
      return TokenModel(input);
    } catch (_) {
      return null;
    }
  }

  // Getters úteis para acessar as partes separadamente
  String get letras => value.substring(0, 4);
  String get numeros => value.substring(5, 9);

  // Serialização para JSON / APIs
  factory TokenModel.fromJson(String json) => TokenModel(json);
  String toJson() => value;

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenModel &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
