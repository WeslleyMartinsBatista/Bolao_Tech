import 'package:flutter/material.dart';

class PalpitesView extends StatefulWidget {
  const PalpitesView({Key? key}) : super(key: key);

  @override
  State<PalpitesView> createState() => _PalpitesViewState();
}

class _PalpitesViewState extends State<PalpitesView> {
  // 0 = Todos, 1 = Finalizados
  int _selectedTab = 0;

  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardBackgroundColor = Color(0xFF1E1E1E);
  static const Color inputBackgroundColor = Color(0xFF262626);
  static const Color primaryGreen = Color(0xFF00E676);
  static const Color textSecondary = Color(0xFFA0A0A0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho superior: Badge Liga Neon e Título
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'LIGA NEON',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Meus Palpites',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 60), // Equilíbrio visual do cabeçalho
                ],
              ),
              const SizedBox(height: 16),

              // Abas de Filtro (Todos / Finalizados)
              Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      title: 'Todos (4)',
                      icon: Icons.track_changes,
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTabButton(
                      title: 'Finalizados',
                      icon: Icons.emoji_events_outlined,
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Card de Resumo: Pontuação Total
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.emoji_events,
                              color: primaryGreen,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Pontuação Total',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '20 pts',
                          style: TextStyle(
                            color: primaryGreen,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatColumn('Cravadas (+10 pts)', '1 jogos'),
                        _buildStatColumn('Resultado (+5 pts)', '2 jogos'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Lista de Palpites (Diferenciação com base na aba ativa)
              if (_selectedTab == 0) ...[
                // Lista na aba "Todos"
                _buildPalpiteCard(
                  palpite: '2×1',
                  confronto: 'Flamengo vs Palmeiras',
                  detalhes: 'Brasileirão Série A · 10 Nov',
                  statusText: 'Pendente',
                  isPendente: true,
                ),
                const SizedBox(height: 10),
                _buildPalpiteCard(
                  palpite: '2×1',
                  confronto: 'Botafogo vs Fluminense',
                  detalhes: 'Brasileirão Série A · 8 Nov',
                  statusText: '+10 pts',
                  isPendente: false,
                ),
                const SizedBox(height: 10),
                _buildPalpiteCard(
                  palpite: '2×0',
                  confronto: 'Red Bull Bragantino vs Cuiabá',
                  detalhes: 'Brasileirão Série A · 7 Nov',
                  statusText: '+5 pts',
                  isPendente: false,
                ),
                const SizedBox(height: 10),
                _buildPalpiteCard(
                  palpite: '1×2',
                  confronto: 'Goiás vs Vitória',
                  detalhes: 'Copa do Brasil · 6 Nov',
                  statusText: '+5 pts',
                  isPendente: false,
                ),
              ] else ...[
                // Lista na aba "Finalizados" (Apenas os finalizados)
                _buildPalpiteCard(
                  palpite: '2×1',
                  confronto: 'Botafogo vs Fluminense',
                  detalhes: 'Brasileirão Série A · 8 Nov',
                  statusText: '+10 pts',
                  isPendente: false,
                ),
                const SizedBox(height: 10),
                _buildPalpiteCard(
                  palpite: '2×0',
                  confronto: 'Red Bull Bragantino vs Cuiabá',
                  detalhes: 'Brasileirão Série A · 7 Nov',
                  statusText: '+5 pts',
                  isPendente: false,
                ),
                const SizedBox(height: 10),
                _buildPalpiteCard(
                  palpite: '1×2',
                  confronto: 'Goiás vs Vitória',
                  detalhes: 'Copa do Brasil · 6 Nov',
                  statusText: '+5 pts',
                  isPendente: false,
                ),
              ],

              const SizedBox(height: 16),

              // Card Informativo: Regras de Pontuação
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: primaryGreen.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: primaryGreen,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Regras de Pontuação',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '10 pts placar exato · 5 pts saldo/vencedor · 3 pts vencedor simples',
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 80,
              ), // Espaço para a barra flutuante inferior
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? primaryGreen : Colors.white12,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryGreen : textSecondary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: textSecondary, fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPalpiteCard({
    required String palpite,
    required String confronto,
    required String detalhes,
    required String statusText,
    required bool isPendente,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // Caixa do Palpite
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isPendente ? inputBackgroundColor : primaryGreen,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isPendente ? Colors.white24 : Colors.transparent,
              ),
            ),
            child: Text(
              palpite,
              style: TextStyle(
                color: isPendente ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Informações do Confronto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  confronto,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detalhes,
                  style: const TextStyle(color: textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          // Status e Ícone de Seta
          Row(
            children: [
              Text(
                statusText,
                style: TextStyle(
                  color: isPendente ? textSecondary : primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: textSecondary, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
