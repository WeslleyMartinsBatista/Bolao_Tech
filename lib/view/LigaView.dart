import 'package:flutter/material.dart';

class LigaView extends StatelessWidget {
  const LigaView({Key? key}) : super(key: key);

  // Paleta de Cores do Design System do BolaoTech
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
              // Cabeçalho / Título e Ícones Superiores
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                  ), // Espaçamento para centralizar o título
                  const Text(
                    'Ligas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: inputBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.white70,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text('|', style: TextStyle(color: Colors.white24)),
                        SizedBox(width: 8),
                        Icon(Icons.add, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Botões de Ação Principais (Criar Liga / Entrar com Código)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.black),
                      label: const Text(
                        'Criar Liga',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.vpn_key_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Entrar com Código',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: cardBackgroundColor,
                        side: const BorderSide(color: Colors.white24, width: 1),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Título da Seção e Contador de Ligas Ativas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Minhas Ligas Privadas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '6 ativas',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Lista de Ligas Privadas
              _buildLigaCard(
                nome: 'Resenha & Palpite',
                campeonato: 'Brasileirão Série A',
                codigo: '#NEON-99',
                participantes: '12 participantes',
                lider: 'Líder: lucas',
              ),
              const SizedBox(height: 12),
              _buildLigaCard(
                nome: 'Resenha & Palpite',
                campeonato: 'Brasileirão Série A',
                codigo: '#CRIAS-10',
                participantes: '8 participantes',
              ),
              const SizedBox(height: 12),
              _buildLigaCard(
                nome: 'Resenha & Palpite',
                campeonato: 'Brasileirão Série A',
                codigo: '#TATIC-05',
                participantes: '5 participantes',
              ),
              const SizedBox(height: 12),
              _buildLigaCard(
                nome: 'Futebol de Terça',
                campeonato: 'Copa do Brasil',
                codigo: '#TERCA-07',
                participantes: '6 participantes',
              ),
              const SizedBox(height: 12),
              _buildLigaCard(
                nome: 'Churrasco FC',
                campeonato: 'Brasileirão Série A',
                codigo: '#CHURR-22',
                participantes: '10 participantes',
              ),

              const SizedBox(
                height: 80,
              ), // Espaço inferior para a barra de navegação flutuante
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLigaCard({
    required String nome,
    required String campeonato,
    required String codigo,
    required String participantes,
    String? lider,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryGreen.withOpacity(0.4)),
                    ),
                    child: const Icon(
                      Icons.emoji_events_outlined,
                      color: primaryGreen,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        campeonato,
                        style: const TextStyle(
                          color: textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: inputBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  codigo,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(color: Colors.white10, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    color: textSecondary,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    participantes,
                    style: const TextStyle(color: textSecondary, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  if (lider != null) ...[
                    Text(
                      lider,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  const Icon(
                    Icons.chevron_right,
                    color: textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
