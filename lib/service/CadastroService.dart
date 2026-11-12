import 'package:supabase_flutter/supabase_flutter.dart';

class CadastroService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> registrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    // 1. Cria a conta no Supabase Authentication
    final AuthResponse res = await _supabase.auth.signUp(
      email: email,
      password: senha,
      data: {'name': nome},
    );

    final user = res.user;

    if (user != null) {
      // 2. Insere o perfil na tabela 'profiles'
      await _supabase.from('profiles').insert({
        'id': user.id,
        'name': nome,
        'email': email,
      });
    } else {
      throw Exception('Não foi possível criar o usuário.');
    }
  }
}
