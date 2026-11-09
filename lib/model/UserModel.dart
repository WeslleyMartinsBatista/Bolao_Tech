enum Cargo { Administrador, GestorFinanceiro, TraderEsportivo, Cliente }

class UserModel {
  String id;
  String nome;
  String email;
  String senha;
  Cargo cargo;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.cargo,
  });
}
