import 'package:flutter/material.dart';
import 'JogosView.dart'; // Certifique-se de importar o arquivo da JogosView

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  static const Color primaryGreen = Color(0xFF00E676);
  static const Color navBackgroundColor = Color(0xFF1E1E1E);

  // Lista de telas correspondentes à navegação inferior
  final List<Widget> _pages = [
    const JogosView(),
    const Center(
      child: Text(
        'Ligas View',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
    const Center(
      child: Text(
        'Palpites View',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // Corpo principal (exibe a tela atual)
          _pages[_currentIndex],

          // Barra de Navegação Inferior Flutuante (Estilo dos Prints)
          Positioned(
            left: 24,
            right: 24,
            bottom: 20,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: navBackgroundColor.withOpacity(0.95),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.white12, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(icon: Icons.calendar_today_outlined, label: 'Jogos', index: 0),
                  _buildNavItem(icon: Icons.people_outline, label: 'Ligas', index: 1),
                  _buildNavItem(icon: Icons.track_changes, label: 'Palpites', index: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryGreen : Colors.white54,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryGreen : Colors.white54,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}