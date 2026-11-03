import 'dart:async';

class LoginService {
  // Simula uma autenticação no servidor
  Future<bool> autenticar(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula delay de rede
    
    if (email == "teste@email.com" && password == "123456") {
      return true;
    }
    return false;
  }
}
