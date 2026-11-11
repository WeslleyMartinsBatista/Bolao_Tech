import 'package:flutter/material.dart';

class JogosView extends StatefulWidget {
  const JogosView({Key? key}) : super(key: key);

  @override
  State<JogosView> createState() => _JogosViewState();
}

class _JogosViewState extends State<JogosView> {
  // 0 = Rodada Aberta, 1 = Resultados Anteriores
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
              // Barra de Busca
              Container(
                decoration: BoxDecoration(
                  color: inputBackgroundColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar times, estádios ou campeonatos',
                    hintStyle: TextStyle(color: textSecondary, fontSize: 13),
                    prefixIcon: Icon(Icons.search, color: textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Filtros de Abas (Rodada Aberta / Resultados Anteriores)
              Row(
                children: [
                  _buildFilterChip('Rodada Aberta', 0),
                  const SizedBox(width: 10),
                  _buildFilterChip('Resultados Anteriores', 1),
                ],
              ),
              const SizedBox(height: 20),

              // Conteúdo Dinâmico Baseado na Aba Selecionada
              if (_selectedTab == 0) ...[
                // CONTEÚDO: RODADA ABERTA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Destaques da Rodada',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'PALPITES ABERTOS',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Card de Destaque horizontal ou vertical
                _buildMatchCard(
                  campeonato: 'Brasileirão Série A',
                  status: 'Aberto',
                  estadio: 'Maracanã',
                  dataHora: 'Amanhã às 19:00',
                  mandante: 'Flamengo',
                  visitante: 'Palmeiras',
                  isEncerrado: false,
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Todos os Jogos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '8 jogos',
                      style: TextStyle(color: textSecondary, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMatchCard(
                  campeonato: 'Brasileirão Série A',
                  status: 'Aberto',
                  estadio: 'Maracanã',
                  dataHora: 'Amanhã às 19:00',
                  mandante: 'Flamengo',
                  visitante: 'Palmeiras',
                  isEncerrado: false,
                ),
                const SizedBox(height: 12),
                _buildMatchCard(
                  campeonato: 'Brasileirão Série A',
                  status: 'Aberto',
                  estadio: 'Neo Química Arena',
                  dataHora: 'Amanhã às 21:30',
                  mandante: 'Corinthians',
                  visitante: 'São Paulo',
                  isEncerrado: false,
                ),
              ] else ...[
                // CONTEÚDO: RESULTADOS ANTERIORES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Partidas Encerradas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '4 jogos',
                      style: TextStyle(color: textSecondary, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMatchCard(
                  campeonato: 'Brasileirão Série A',
                  status: 'Palpite 2×1',
                  estadio: 'Nilton Santos',
                  dataHora: 'Sun, 31 May',
                  mandante: 'Botafogo',
                  visitante: 'Fluminense',
                  isEncerrado: true,
                  placar: '2 - 1',
                  pontosPalpite: '580 pts',
                ),
                const SizedBox(height: 12),
                _buildMatchCard(
                  campeonato: 'Brasileirão Série A',
                  status: 'Palpite 2×0',
                  estadio: 'Nabi Abi Chedid',
                  dataHora: 'Sat, 30 May',
                  mandante: 'Red Bull Bragantino',
                  visitante: 'Cuiabá',
                  isEncerrado: true,
                  placar: '1 - 0',
                  pontosPalpite: '580 pts',
                ),
              ],
              const SizedBox(height: 80), // Espaço para a bottom bar flutuante
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : cardBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard({
    required String campeonato,
    required String status,
    required String estadio,
    required String dataHora,
    required String mandante,
    required String visitante,
    required bool isEncerrado,
    String? placar,
    String? pontosPalpite,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryGreen.withOpacity(0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho do Card (Campo de futebol estilizado no fundo/topo)
          Container(
            height: 70,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1508098682722-e99c43a406b2?q=80&w=600&auto=format&fit=crop'), // Imagem ilustrativa de gramado/estádio
                fit: BoxFit.cover,
                opacity: 0.35,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Text(
                    campeonato,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isEncerrado ? primaryGreen.withOpacity(0.85) : primaryGreen,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: isEncerrado ? Colors.black : Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isEncerrado && pontosPalpite != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'SAVED $pontosPalpite',
                        style: const TextStyle(color: textSecondary, fontSize: 9),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
          
          // Estádio e Data
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(estadio, style: const TextStyle(color: textSecondary, fontSize: 11)),
                Text(dataHora, style: const TextStyle(color: textSecondary, fontSize: 11)),
              ],
            ),
          ),

          // Times e Placar / VS
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mandante,
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text('Mandante', style: TextStyle(color: textSecondary, fontSize: 10)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: inputBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isEncerrado ? primaryGreen : Colors.white24),
                  ),
                  child: Text(
                    isEncerrado ? placar ?? '0 - 0' : 'VS',
                    style: TextStyle(
                      color: isEncerrado ? primaryGreen : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        visitante,
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text('Visitante', style: TextStyle(color: textSecondary, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}