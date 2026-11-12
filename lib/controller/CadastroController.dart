import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../service/CadastroService.dart';

class CadastroController {
  final CadastroService _service = CadastroService();

  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
  }

  Future<bool> cadastrar({
    required Function(bool) onLoadingChanged,
    required Function(String) onError,
    required VoidCallback onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) return false;

    onLoadingChanged(true);

    try {
      await _service.registrarUsuario(
        nome: nomeController.text.trim(),
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
      );
      onSuccess();
      return true;
    } on AuthException catch (e) {
      onError(_traduzirErroAuth(e.message));
      return false;
    } catch (e) {
      onError('Erro inesperado ao criar conta. Tente novamente.');
      return false;
    } finally {
      onLoadingChanged(false);
    }
  }

  String _traduzirErroAuth(String mensagem) {
    if (mensagem.contains('User already registered')) {
      return 'Este e-mail já está cadastrado.';
    }
    if (mensagem.contains('Password should be at least')) {
      return 'A senha deve ter no mínimo 6 caracteres.';
    }
    if (mensagem.contains('Invalid email')) {
      return 'Informe um endereço de e-mail válido.';
    }
    return mensagem;
  }
}
