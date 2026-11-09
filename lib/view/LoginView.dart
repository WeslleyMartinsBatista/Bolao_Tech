import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Paleta de Cores baseada na UI fornecida
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Logo Circular com a Imagem do Asset
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: cardBackgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryGreen.withOpacity(0.3), width: 1.5),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'lib/resources/Logo_BolaoTech.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Título e Subtítulo
              const Text(
                'Bem-vindo de volta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Entre para conferir os palpites e rodadas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),

              // Campo de Email
              const Text(
                'E-mail',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Seu e-mail',
                  hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
                  filled: true,
                  fillColor: inputBackgroundColor,
                  prefixIcon: const Icon(Icons.email_outlined, color: textSecondary),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryGreen, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de Senha
              const Text(
                'Senha',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Sua senha',
                  hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
                  filled: true,
                  fillColor: inputBackgroundColor,
                  prefixIcon: const Icon(Icons.lock_outline, color: textSecondary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryGreen, width: 1.5),
                  ),
                ),
              ),

              // Esqueceu a senha
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Esqueceu a senha?',
                    style: TextStyle(color: textSecondary, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botão Principal (Entrar)
              ElevatedButton(
                onPressed: () {
                  // Ação de Login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'ENTRAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Divider "ou"
              Row(
                children: const [
                  Expanded(child: Divider(color: inputBackgroundColor, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('ou', style: TextStyle(color: textSecondary)),
                  ),
                  Expanded(child: Divider(color: inputBackgroundColor, thickness: 1)),
                ],
              ),
              const SizedBox(height: 32),

              // Registro / Criar Conta
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não tem uma conta?',
                    style: TextStyle(color: textSecondary),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}