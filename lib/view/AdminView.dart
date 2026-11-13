import 'package:flutter/material.dart';

import '../controller/AdminController.dart';
import '../widgets/CardJogoWidget.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final AdminController _controller = AdminController();

  bool _isSaving = false;
  bool _isLoadingDados = true;

  Map<String, int> _stats = {
    'usuarios': 0,
    'jogos': 0,
    'palpites': 0,
    'ligas': 0,
  };
  List<Map<String, dynamic>> _jogos = [];

  // Paleta padrão BolaoTech
  static const Color _bgDark = Color(0xFF121212);
  static const Color _cardDark = Color(0xFF1E1E1E);
  static const Color _inputBg = Color(0xFF262626);
  static const Color _primaryGreen = Color(0xFF00E676);
  static const Color _textSecondary = Color(0xFFA0A0A0);

  @override
  void initState() {
    super.initState();
    _atualizarPainel();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _atualizarPainel() async {
    setState(() => _isLoadingDados = true);
    final stats = await _controller.carregarEstatisticas();
    final jogos = await _controller.carregarJogos();

    if (mounted) {
      setState(() {
        _stats = stats;
        _jogos = jogos;
        _isLoadingDados = false;
      });
    }
  }

  void _criarNovoCardJogo() {
    _controller.salvarNovoJogo(
      onLoadingChanged: (loading) => setState(() => _isSaving = loading),
      onError: (msg) => _mostrarSnackBar(msg, Colors.redAccent),
      onSuccess: () {
        _mostrarSnackBar(
          'Partida criada e publicada com sucesso!',
          Colors.green,
        );
        _atualizarPainel();
      },
    );
  }

  void _mostrarSnackBar(String mensagem, Color cor) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem), backgroundColor: cor));
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _textSecondary, fontSize: 13),
      filled: true,
      fillColor: _inputBg,
      prefixIcon: Icon(icon, color: _primaryGreen, size: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryGreen, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  Widget _buildStatCard({
    required String titulo,
    required int valor,
    required IconData icone,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primaryGreen.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icone, color: _primaryGreen, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            valor.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDark,
      appBar: AppBar(
        backgroundColor: _cardDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: _primaryGreen),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.admin_panel_settings, color: _primaryGreen),
            SizedBox(width: 8),
            Text(
              'Painel do Administrador',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Atualizar dados',
            onPressed: _atualizarPainel,
            icon: const Icon(Icons.refresh, color: _primaryGreen),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SEÇÃO 1: VISÃO GERAL DO SISTEMA
                  const Text(
                    'Visão Geral do Sistema',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _isLoadingDados
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: _primaryGreen,
                            ),
                          ),
                        )
                      : GridView.count(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 500 ? 4 : 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.35,
                          children: [
                            _buildStatCard(
                              titulo: 'Usuários',
                              valor: _stats['usuarios'] ?? 0,
                              icone: Icons.people_outline,
                            ),
                            _buildStatCard(
                              titulo: 'Jogos',
                              valor: _stats['jogos'] ?? 0,
                              icone: Icons.sports_soccer,
                            ),
                            _buildStatCard(
                              titulo: 'Palpites',
                              valor: _stats['palpites'] ?? 0,
                              icone: Icons.analytics_outlined,
                            ),
                            _buildStatCard(
                              titulo: 'Ligas',
                              valor: _stats['ligas'] ?? 0,
                              icone: Icons.emoji_events_outlined,
                            ),
                          ],
                        ),

                  const SizedBox(height: 32),

                  // SEÇÃO 2: CRIAR NOVO CARD DE JOGO
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _cardDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _primaryGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Form(
                      key: _controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: _primaryGreen,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Cadastrar Nova Partida',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'O card aparecerá imediatamente para palpites dos usuários.',
                            style: TextStyle(
                              color: _textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Linha Time da Casa x Time Visitante
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('Time da Casa'),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller:
                                          _controller.timeCasaController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: _inputDecoration(
                                        hintText: 'Ex: Grêmio',
                                        icon: Icons.shield_outlined,
                                      ),
                                      validator: (v) =>
                                          (v == null || v.trim().isEmpty)
                                          ? 'Obrigatório'
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('Time Visitante'),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller:
                                          _controller.timeForaController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: _inputDecoration(
                                        hintText: 'Ex: Internacional',
                                        icon: Icons.shield,
                                      ),
                                      validator: (v) =>
                                          (v == null || v.trim().isEmpty)
                                          ? 'Obrigatório'
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Linha URLs dos Escudos (Opcional)
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('URL Escudo Casa (opcional)'),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller:
                                          _controller.escudoCasaController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: _inputDecoration(
                                        hintText: 'https://...',
                                        icon: Icons.image_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel(
                                      'URL Escudo Visitante (opcional)',
                                    ),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller:
                                          _controller.escudoForaController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: _inputDecoration(
                                        hintText: 'https://...',
                                        icon: Icons.image_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Linha Data/Hora e Campeonato
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('Data e Horário'),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller:
                                          _controller.dataHoraController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: _inputDecoration(
                                        hintText: 'Ex: Dom, 15/11 • 16:00',
                                        icon: Icons.calendar_today_outlined,
                                      ),
                                      validator: (v) =>
                                          (v == null || v.trim().isEmpty)
                                          ? 'Informe data/hora'
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('Campeonato'),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller:
                                          _controller.campeonatoController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: _inputDecoration(
                                        hintText: 'Ex: Brasileirão Série A',
                                        icon: Icons.emoji_events_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Botão Publicar Card de Jogo
                          SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: _isSaving ? null : _criarNovoCardJogo,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _primaryGreen,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              icon: _isSaving
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Icon(Icons.publish),
                              label: Text(
                                _isSaving
                                    ? 'SALVANDO...'
                                    : 'CRIAR CARD DE JOGO',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // SEÇÃO 3: PARTIDAS CADASTRADAS NO SISTEMA
                  const Text(
                    'Partidas Cadastradas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (_jogos.isEmpty && !_isLoadingDados)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Nenhuma partida cadastrada ainda.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _textSecondary),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _jogos.length,
                      itemBuilder: (context, index) {
                        final jogo = _jogos[index];
                        return Stack(
                          children: [
                            CardJogoWidget(
                              timeCasa: jogo['home_team'] ?? 'Time A',
                              timeFora: jogo['away_team'] ?? 'Time B',
                              escudoCasa: jogo['home_badge_url'],
                              escudoFora: jogo['away_badge_url'],
                              dataHora: jogo['match_date'] ?? '',
                              status: jogo['status'] ?? 'pendente',
                              placarCasa: jogo['home_score'],
                              placarFora: jogo['away_score'],
                              onTapPalpite: () {},
                            ),
                            Positioned(
                              top: 14,
                              right: 24,
                              child: IconButton(
                                tooltip: 'Remover partida',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await _controller.deletarJogo(
                                    jogo['id'],
                                    _atualizarPainel,
                                  );
                                  _mostrarSnackBar(
                                    'Partida removida.',
                                    Colors.orange,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
