import 'package:flutter/material.dart';

class CardJogoWidget extends StatelessWidget {
  final String timeCasa;
  final String timeFora;
  final String? escudoCasa; // URL da imagem ou asset do escudo
  final String? escudoFora;
  final String dataHora;
  final String status; // Ex: 'pendente', 'encerrado', etc.
  final int? placarCasa;
  final int? placarFora;
  final VoidCallback onTapPalpite;

  const CardJogoWidget({
    Key? key,
    required this.timeCasa,
    required this.timeFora,
    this.escudoCasa,
    this.escudoFora,
    required this.dataHora,
    required this.status,
    this.placarCasa,
    this.placarFora,
    required this.onTapPalpite,
  }) : super(key: key);

  // Paleta de cores do BolaoTech
  static const Color _cardDark = Color(0xFF1E1E1E);
  static const Color _inputBg = Color(0xFF262626);
  static const Color _primaryGreen = Color(0xFF00E676);
  static const Color _textSecondary = Color(0xFFA0A0A0);

  @override
  Widget build(BuildContext context) {
    bool jogoEncerrado = status == 'encerrado';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _primaryGreen.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Data / Horário ou Status da Partida no topo
          Text(
            dataHora,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),

          // Linha principal com Time Casa vs Time Fora e Placar/X
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Time da Casa
              Expanded(
                child: Column(
                  children: [
                    _buildEscudo(escudoCasa),
                    const SizedBox(height: 8),
                    Text(
                      timeCasa,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Placar ou "X" central
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _inputBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Text(
                    jogoEncerrado && placarCasa != null && placarFora != null
                        ? '$placarCasa x $placarFora'
                        : 'VS',
                    style: TextStyle(
                      color: jogoEncerrado ? _primaryGreen : _textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Time de Fora
              Expanded(
                child: Column(
                  children: [
                    _buildEscudo(escudoFora),
                    const SizedBox(height: 8),
                    Text(
                      timeFora,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Botão de Ação / Palpite
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              onPressed: onTapPalpite,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: _primaryGreen, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: _primaryGreen,
              ),
              child: Text(
                jogoEncerrado ? 'Ver Resultado' : 'Fazer / Ver Palpite',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para exibir o escudo (suporta URL web ou ícone padrão caso venha nulo)
  Widget _buildEscudo(String? url) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _inputBg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: ClipOval(
        child: url != null && url.isNotEmpty
            ? Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.sports_soccer,
                  color: _primaryGreen,
                  size: 22,
                ),
              )
            : const Icon(Icons.sports_soccer, color: _primaryGreen, size: 22),
      ),
    );
  }
}
