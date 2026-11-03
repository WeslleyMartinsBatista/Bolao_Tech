import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../controller/LoginController.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _controller = LoginController();

  @override
  void initState() {
    super.initState();
    _controller.init(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. O Background que acende apenas as escamas dentro da área invisível ativa
          Positioned.fill(
            child: CustomPaint(
              painter: SoccerBackgroundPainter(activeAreaRect: _controller.activeAreaRect),
            ),
          ),
          // 2. Interface do Formulário de Login
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Campo de Email com chave e foco mapeados
                    Container(
                      key: _controller.emailKey,
                      child: TextField(
                        controller: _controller.emailController,
                        focusNode: _controller.emailFocus,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Email'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Campo de Senha com chave e foco mapeados
                    Container(
                      key: _controller.passwordKey,
                      child: TextField(
                        controller: _controller.passwordController,
                        focusNode: _controller.passwordFocus,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Senha'),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF39FF14),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _controller.isLoading
                          ? null
                          : () {
                              _controller.efetuarLogin(
                                onStartLoading: () => setState(() {}),
                                onResult: (sucesso) {
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(sucesso
                                          ? 'Login efetuado com sucesso!'
                                          : 'Email ou senha incorretos.'),
                                    ),
                                  );
                                },
                              );
                            },
                      child: _controller.isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text('ENTRAR', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.black.withOpacity(0.75),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white24),
      ),
    );
  }
}

class SoccerBackgroundPainter extends CustomPainter {
  final Rect? activeAreaRect;
  SoccerBackgroundPainter({this.activeAreaRect});

  @override
  void paint(Canvas canvas, Size size) {
    final paintHexagon = Paint()
      ..color = const Color(0xFF121212)
      ..style = PaintingStyle.fill;

    final paintLine = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Configurações do neon
    final paintNeonBlur = Paint()
      ..color = const Color(0xFF39FF14).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final paintNeonCore = Paint()
      ..color = const Color(0xFF39FF14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    double radius = 35.0; // Reduzido ligeiramente para dar maior precisão de encaixe na caixa
    double hexWidth = radius * math.sqrt(3);
    double hexHeight = radius * 2;

    for (double y = -radius; y < size.height + radius; y += hexHeight * 0.75) {
      bool odd = ((y + radius) / (hexHeight * 0.75)).round() % 2 == 1;
      for (double x = -hexWidth; x < size.width + hexWidth; x += hexWidth) {
        double cx = x + (odd ? hexWidth / 2 : 0);
        double cy = y;

        Path hexPath = _getHexagonPath(cx, cy, radius);
        
        // Desenha a escama padrão (apagada)
        canvas.drawPath(hexPath, paintHexagon);
        canvas.drawPath(hexPath, paintLine);

        // Se uma caixa de texto estiver focada, verifica se este hexágono está na área invisível
        if (activeAreaRect != null) {
          // Cria uma caixa delimitadora para este hexágono específico
          Rect hexBox = Rect.fromCenter(center: Offset(cx, cy), width: hexWidth, height: hexHeight);
          
          // Se a caixa do hexágono interceptar a área invisível expandida do input, acende ele!
          if (activeAreaRect!.overlaps(hexBox)) {
            canvas.drawPath(hexPath, paintNeonBlur);
            canvas.drawPath(hexPath, paintNeonCore);
          }
        }
      }
    }
  }

  Path _getHexagonPath(double x, double y, double radius) {
    Path path = Path();
    for (int i = 0; i < 6; i++) {
      double angle = (math.pi / 3) * i + (math.pi / 6);
      double xPoint = x + radius * math.cos(angle);
      double yPoint = y + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(xPoint, yPoint);
      } else {
        path.lineTo(xPoint, yPoint);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant SoccerBackgroundPainter oldDelegate) {
    return oldDelegate.activeAreaRect != activeAreaRect;
  }
}
