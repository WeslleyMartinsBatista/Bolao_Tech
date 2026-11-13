import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Autentica o usuário consultando diretamente a tabela `usuarios` no Supabase
  Future<bool> autenticar(String email, String senha) async {
    try {
      // Faz a consulta na tabela buscando o registro com o e-mail e senha informados
      final response = await _supabase
          .from('usuarios')
          .select()
          .eq('email', email.trim())
          .eq('senha', senha.trim())
          .maybeSingle();

      // Se encontrou um registro correspondente, o login é válido
      return response != null;
    } catch (e) {
      print('Erro ao autenticar: $e');
      return false;
    }
  }

  /// Opcional: Busca os dados completos do usuário logado (incluindo o cargo)
  Future<Map<String, dynamic>?> obterDadosUsuario(String email) async {
    try {
      final response = await _supabase
          .from('usuarios')
          .select()
          .eq('email', email.trim())
          .maybeSingle();

      return response;
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
      return null;
    }
  }
}
