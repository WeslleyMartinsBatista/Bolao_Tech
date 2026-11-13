import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Busca os números totais do sistema para a visão geral
  Future<Map<String, int>> obterResumoSistema() async {
    final usersRes = await _supabase.from('profiles').select('id');
    final matchesRes = await _supabase.from('matches').select('id');
    final predictionsRes = await _supabase.from('predictions').select('id');
    final leaguesRes = await _supabase.from('leagues').select('id');

    return {
      'usuarios': (usersRes as List).length,
      'jogos': (matchesRes as List).length,
      'palpites': (predictionsRes as List).length,
      'ligas': (leaguesRes as List).length,
    };
  }

  /// Lista as partidas cadastradas (mais recentes primeiro)
  Future<List<Map<String, dynamic>>> listarJogos() async {
    final response = await _supabase
        .from('matches')
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Insere um novo jogo na tabela 'matches'
  Future<void> criarJogo({
    required String timeCasa,
    required String timeFora,
    String? escudoCasa,
    String? escudoFora,
    required String dataHora,
    String? campeonato,
  }) async {
    await _supabase.from('matches').insert({
      'home_team': timeCasa,
      'away_team': timeFora,
      'home_badge_url': escudoCasa != null && escudoCasa.isNotEmpty
          ? escudoCasa
          : null,
      'away_badge_url': escudoFora != null && escudoFora.isNotEmpty
          ? escudoFora
          : null,
      'match_date': dataHora,
      'championship': campeonato != null && campeonato.isNotEmpty
          ? campeonato
          : 'Geral',
      'status': 'pendente',
    });
  }

  /// Exclui um jogo pelo ID
  Future<void> excluirJogo(dynamic matchId) async {
    await _supabase.from('matches').delete().eq('id', matchId);
  }
}
