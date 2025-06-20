import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para debugPrint
import 'app_colors.dart';
import 'register_screen.dart';
import 'main_screen.dart'; // Para login de usuário comum
import 'main_screen_advogado.dart'; // <<< NOVO IMPORT para a tela do advogado

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _loginUsuarioComum() {
    // Validação comentada para login direto
    debugPrint('Botão Entrar (Usuário Comum) clicado - Login simulado direto para MainScreen');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login de Usuário direto para teste!')),
    );
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  void _loginAdvogado() {
    // Validação comentada para login direto
    debugPrint('Botão Entrar (Advogado) clicado - Login simulado direto para MainScreenAdvogado');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login de Advogado direto para teste!')),
    );
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreenAdvogado()), // <<< NAVEGA PARA A TELA DO ADVOGADO
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/icon/icon.png',
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          color: Colors.red.withOpacity(0.1),
                          alignment: Alignment.center,
                          child: const Text(
                            'Falha ao carregar logo\nVerifique assets/icon/icon.png\ne pubspec.yaml',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Acessar sua Conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: azulEscuro,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email ou Celular',
                        hintText: 'seuemail@exemplo.com',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu email ou celular';
                        }
                        if (!value.contains('@') && value.length < 10) {
                           return 'Email ou celular inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                       validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Funcionalidade "Esqueci senha" (TODO)')),
                            );
                          },
                          child: const Text('Esqueci minha senha'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: _loginUsuarioComum, // Chama o login de usuário comum
                      child: const Text('Entrar como Usuário'),
                    ),
                    const SizedBox(height: 15.0), // Espaço entre os botões
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: azulMedio, // Cor diferente para o botão de advogado
                      ),
                      onPressed: _loginAdvogado, // Chama o login de advogado
                      child: const Text('Entrar como Advogado (Simulação)'),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem uma conta? ', style: TextStyle(color: cinzaTexto)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
