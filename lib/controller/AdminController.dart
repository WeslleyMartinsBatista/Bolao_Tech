import 'package:flutter/material.dart';

import '../service/AdminService.dart';

class AdminController {
  final AdminService _service = AdminService();

  final formKey = GlobalKey<FormState>();
  final timeCasaController = TextEditingController();
  final timeForaController = TextEditingController();
  final escudoCasaController = TextEditingController();
  final escudoForaController = TextEditingController();
  final dataHoraController = TextEditingController();
  final campeonatoController = TextEditingController();

  void dispose() {
    timeCasaController.dispose();
    timeForaController.dispose();
    escudoCasaController.dispose();
    escudoForaController.dispose();
    dataHoraController.dispose();
    campeonatoController.dispose();
  }

  void limparFormulario() {
    timeCasaController.clear();
    timeForaController.clear();
    escudoCasaController.clear();
    escudoForaController.clear();
    dataHoraController.clear();
    campeonatoController.clear();
  }

  Future<Map<String, int>> carregarEstatisticas() async {
    try {
      return await _service.obterResumoSistema();
    } catch (_) {
      return {'usuarios': 0, 'jogos': 0, 'palpites': 0, 'ligas': 0};
    }
  }

  Future<List<Map<String, dynamic>>> carregarJogos() async {
    return await _service.listarJogos();
  }

  Future<bool> salvarNovoJogo({
    required Function(bool) onLoadingChanged,
    required Function(String) onError,
    required VoidCallback onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) return false;

    onLoadingChanged(true);

    try {
      await _service.criarJogo(
        timeCasa: timeCasaController.text.trim(),
        timeFora: timeForaController.text.trim(),
        escudoCasa: escudoCasaController.text.trim(),
        escudoFora: escudoForaController.text.trim(),
        dataHora: dataHoraController.text.trim(),
        campeonato: campeonatoController.text.trim(),
      );
      limparFormulario();
      onSuccess();
      return true;
    } catch (e) {
      onError('Erro ao salvar partida: $e');
      return false;
    } finally {
      onLoadingChanged(false);
    }
  }

  Future<void> deletarJogo(dynamic id, VoidCallback onDeleted) async {
    await _service.excluirJogo(id);
    onDeleted();
  }
}
