import 'dart:async';

import '../database/MockDatabase.dart';

class LoginService {
  // Simula uma autenticação no servidor consultando o MockDatabase
  Future<bool> autenticar(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula delay de rede

    // Verifica se existe algum usuário na lista do MockDatabase com o e-mail e senha correspondentes
    bool usuarioValido = MockDatabase.usuarios.any(
      (user) => user.email == email && user.senha == password,
    );

    return usuarioValido;
  }
}
