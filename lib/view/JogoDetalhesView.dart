import 'package:flutter/material.dart';

class JogoDetalhesView extends StatelessWidget {
  final bool isEncerrado;
  final bool temPalpite;
  final String campeonato;
  final String mandante;
  final String visitante;
  final String dataOuHorario;
  final String estadio;
  final String? placarOficial;
  final String? palpiteRegistrado;
  final String? pontosObtidos; // Ex: "+10 pts"
  final double vitoriaMandantePct;
  final double empatePct;
  final double vitoriaVisitantePct;
  final int totalAmigos;
  final String? pontosSalvosTopo; // Ex: "580" para jogos encerrados

  const JogoDetalhesView({
    Key? key,
    required this.isEncerrado,
    required this.temPalpite,
    required this.campeonato,
    required this.mandante,
    required this.visitante,
    required this.dataOuHorario,
    required this.estadio,
    this.placarOficial,
    this.palpiteRegistrado,
    this.pontosObtidos,
    required this.vitoriaMandantePct,
    required this.empatePct,
    required this.vitoriaVisitantePct,
    required this.totalAmigos,
    this.pontosSalvosTopo,
  }) : super(key: key);

  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardBackgroundColor = Color(0xFF1E1E1E);
  static const Color inputBackgroundColor = Color(0xFF262626);
  static const Color primaryGreen = Color(0xFF00E676);
  static const Color textSecondary = Color(0xFFA0A0A0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER COM IMAGEM DE FUNDO E STATUS
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?q=80&w=800&auto=format&fit=crop',
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.45,
                    ),
                  ),
                ),
                // Gradiente escuro para suavizar a transição
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        backgroundColor,
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Botão Voltar
                        CircleAvatar(
                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        // Badge de Status Superior Direito
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: primaryGreen, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isEncerrado ? Icons.check_circle_outline : Icons.access_time,
                                color: primaryGreen,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isEncerrado ? 'Encerrado' : dataOuHorario,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Se for encerrado, exibe os pontos salvos no canto superior direito da imagem
                if (isEncerrado && pontosSalvosTopo != null)
                  Positioned(
                    top: 80,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: inputBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('SAVED PREDICTS', style: TextStyle(color: textSecondary, fontSize: 8, fontWeight: FontWeight.bold)),
                          Text(
                            '$pontosSalvosTopo ⚽',
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // CONTEÚDO PRINCIPAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),

                  // CARD CENTRAL DO CONFRONTO (Placar ou VS)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          campeonato,
                          style: const TextStyle(
                            color: primaryGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Mandante
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: inputBackgroundColor,
                                    radius: 22,
                                    child: Text(
                                      mandante[0],
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    mandante,
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text('Mandante', style: TextStyle(color: textSecondary, fontSize: 10)),
                                ],
                              ),
                            ),
                            // Meio (Placar ou VS)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    isEncerrado ? (placarOficial ?? '0 x 0') : 'VS',
                                    style: TextStyle(
                                      color: isEncerrado ? primaryGreen : Colors.white,
                                      fontSize: isEncerrado ? 24 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isEncerrado ? 'Placar Oficial' : dataOuHorario,
                                    style: const TextStyle(color: textSecondary, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            // Visitante
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: inputBackgroundColor,
                                    radius: 22,
                                    child: Text(
                                      visitante[0],
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    visitante,
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text('Visitante', style: TextStyle(color: textSecondary, fontSize: 10)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on_outlined, color: textSecondary, size: 14),
                            const SizedBox(width: 4),
                            Text(estadio, style: const TextStyle(color: textSecondary, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // CARD DO STATUS DO PALPITE DO USUÁRIO
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: temPalpite ? primaryGreen.withValues(alpha: 0.2) : inputBackgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                temPalpite ? Icons.check : Icons.edit_outlined,
                                color: temPalpite ? primaryGreen : textSecondary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  temPalpite ? 'Seu Palpite Registrado' : 'Nenhum Palpite Enviado',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  temPalpite
                                      ? 'Placar previsto: $palpiteRegistrado'
                                      : 'Faça seu palpite antes do início',
                                  style: const TextStyle(color: textSecondary, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (temPalpite && pontosObtidos != null)
                          Text(
                            pontosObtidos!,
                            style: const TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ESTATÍSTICAS / PALPITES DA COMUNIDADE
                  const Text(
                    'Palpites da Comunidade',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
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
                        Text(
                          '$totalAmigos palpites registrados pelos amigos',
                          style: const TextStyle(color: textSecondary, fontSize: 12),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(child: _buildCommunityStatBox('${vitoriaMandantePct.toInt()}%', 'Vitória $mandante...')),
                            const SizedBox(width: 8),
                            Expanded(child: _buildCommunityStatBox('${empatePct.toInt()}%', 'Empate')),
                            const SizedBox(width: 8),
                            Expanded(child: _buildCommunityStatBox('${vitoriaVisitantePct.toInt()}%', 'Vitória $visitante...')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      // BARRA INFERIOR DINÂMICA (Depende se o jogo está aberto e se tem palpite)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          border: const Border(top: BorderSide(color: Colors.white12)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEncerrado
                        ? 'Partida Encerrada'
                        : (temPalpite ? 'Palpite Registrado' : 'Apostas Abertas'),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    isEncerrado
                        ? 'Pontuação computada'
                        : (temPalpite ? palpiteRegistrado ?? '' : 'Limite até o início'),
                    style: const TextStyle(color: textSecondary, fontSize: 11),
                  ),
                ],
              ),
              if (!isEncerrado)
                ElevatedButton.icon(
                  onPressed: () {
                    // Ação para Dar ou Editar Palpite
                  },
                  icon: Icon(
                    temPalpite ? Icons.track_changes : Icons.add_circle_outline,
                    color: Colors.black,
                    size: 18,
                  ),
                  label: Text(
                    temPalpite ? 'Editar Palpite' : 'Dar Palpite',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityStatBox(String percentage, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: inputBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(
            percentage,
            style: const TextStyle(
              color: primaryGreen,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: textSecondary, fontSize: 10),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}