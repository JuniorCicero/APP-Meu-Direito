import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para debugPrint
import 'app_colors.dart';
import 'login_screen.dart'; // Para o logout

// --- Placeholders para as telas de cada aba do Advogado ---
class NovosLeadsScreenPlaceholder extends StatelessWidget {
  const NovosLeadsScreenPlaceholder({super.key});

  // TODO: No futuro, esta tela lerá a lista 'leadsGlobaisSimulados'
  // que será preenchida quando um usuário enviar uma análise.

  @override
  Widget build(BuildContext context) {
    // Temporariamente, uma lista fictícia aqui para demonstração do layout
    final List<Map<String, String>> leadsFicticios = [
      {'id': '1', 'area': 'Direito do Consumidor', 'resumo': 'Problema com garantia de produto eletrônico...'},
      {'id': '2', 'area': 'Direito Trabalhista', 'resumo': 'Dúvidas sobre cálculo de horas extras e rescisão...'},
      {'id': '3', 'area': 'Direito Imobiliário', 'resumo': 'Questão sobre contrato de aluguel e reparos...'},
    ];

    if (leadsFicticios.isEmpty) { // No futuro, verificará a lista global
        return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.playlist_add_check_circle_outlined, size: 80, color: cinzaTexto),
            SizedBox(height: 20),
            Text(
              'Nenhum novo lead no momento.',
              style: TextStyle(fontSize: 18, color: cinzaTexto),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: leadsFicticios.length, // No futuro, usará leadsGlobaisSimulados.length
      itemBuilder: (context, index) {
        final lead = leadsFicticios[index]; // No futuro, usará leadsGlobaisSimulados[index]
        return Card(
          elevation: 1.5,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Novo Lead: ${lead['area']}',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: azulEscuro),
                ),
                const SizedBox(height: 8),
                Text(
                  lead['resumo']!,
                  style: const TextStyle(fontSize: 14, color: cinzaTexto),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Recusar', style: TextStyle(color: Colors.redAccent)),
                      onPressed: () {
                        // TODO: Lógica para recusar o lead
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lead "${lead['resumo']!.substring(0,10)}..." recusado (Simulação)')),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: verdeSucesso),
                      child: const Text('Aceitar Caso', style: TextStyle(color: branco)),
                      onPressed: () {
                        // TODO: Lógica para aceitar o caso e contatar usuário
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lead "${lead['resumo']!.substring(0,10)}..." aceito! (Simulação)')),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CasosAtivosAdvScreenPlaceholder extends StatelessWidget {
  const CasosAtivosAdvScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tela de Casos Ativos (Advogado - Placeholder)', style: TextStyle(fontSize: 20, color: cinzaTexto)),
    );
  }
}

class PerfilAdvScreenPlaceholder extends StatelessWidget {
  const PerfilAdvScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tela de Perfil (Advogado - Placeholder)', style: TextStyle(fontSize: 20, color: cinzaTexto)),
    );
  }
}


class MainScreenAdvogado extends StatefulWidget {
  const MainScreenAdvogado({super.key});

  @override
  State<MainScreenAdvogado> createState() => _MainScreenAdvogadoState();
}

class _MainScreenAdvogadoState extends State<MainScreenAdvogado> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    NovosLeadsScreenPlaceholder(),
    CasosAtivosAdvScreenPlaceholder(),
    PerfilAdvScreenPlaceholder(),
  ];

  static const List<String> _appBarTitles = <String>[
    'Novos Leads',
    'Meus Casos Ativos',
    'Meu Perfil (Advogado)',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    debugPrint("Botão Sair (Advogado) pressionado - Efetuando Logout Simulado");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout de Advogado efetuado!')),
    );
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
        actions: [
          if (_selectedIndex == 2) // Mostrar botão de Sair apenas na aba Perfil
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              tooltip: 'Sair',
              onPressed: _logout,
            ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_outlined),
            activeIcon: Icon(Icons.new_releases),
            label: 'Novos Leads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history_outlined),
            activeIcon: Icon(Icons.work_history),
            label: 'Casos Ativos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_badge_outlined),
            activeIcon: Icon(Icons.person_badge),
            label: 'Perfil Adv.',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: azulEscuro,
        unselectedItemColor: azulMedio.withOpacity(0.7),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
