import 'package:flutter/material.dart';
import '../service/LoginService.dart';

class LoginController {
  final LoginService _loginService = LoginService();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final GlobalKey emailKey = GlobalKey();
  final GlobalKey passwordKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Rect? activeAreaRect;
  bool isLoading = false;

  void init(VoidCallback onFocusChanged) {
    emailFocus.addListener(() => _updateActiveArea(onFocusChanged));
    passwordFocus.addListener(() => _updateActiveArea(onFocusChanged));
  }

  void _updateActiveArea(VoidCallback onFocusChanged) {
    if (emailFocus.hasFocus) {
      // CORREÇÃO: Reduzido de 40 para 10 para evitar colisões com o campo de baixo
      activeAreaRect = _getWidgetRect(emailKey)?.inflate(10);
    } else if (passwordFocus.hasFocus) {
      // CORREÇÃO: Reduzido de 40 para 10 para evitar colisões com o campo de cima
      activeAreaRect = _getWidgetRect(passwordKey)?.inflate(10);
    } else {
      activeAreaRect = null;
    }
    onFocusChanged();
  }

  Rect? _getWidgetRect(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
  }

  Future<void> efetuarLogin({
    required VoidCallback onStartLoading,
    required Function(bool sucesso) onResult,
  }) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) return;

    isLoading = true;
    onStartLoading();

    bool sucesso = await _loginService.autenticar(
      emailController.text,
      passwordController.text,
    );

    isLoading = false;
    onResult(sucesso);
  }

  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
