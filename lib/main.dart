import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final String correctUsername = "admin";
  final String correctPassword = "1234";

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showMessage("Preencha todos os campos.");
    } else if (username == correctUsername && password == correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen(username: username)),
      );
    } else {
      _showMessage("Usuário ou senha incorretos.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Usuário"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Senha",
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  final String username;
  const WelcomeScreen({super.key, required this.username});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cursoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _paisController = TextEditingController();

  void _salvarDados() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Dados salvos"),
        content: Text(
          "Nome: ${_nomeController.text}\n"
          "Endereço: ${_enderecoController.text}\n"
          "Curso: ${_cursoController.text}\n"
          "Cidade: ${_cidadeController.text}\n"
          "País: ${_paisController.text}",
        ),
        actions: [
          TextButton(
            child: const Text("Fechar"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _voltarLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Bem-vindo, ${widget.username}!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: "Nome")),
            TextField(controller: _enderecoController, decoration: const InputDecoration(labelText: "Endereço")),
            TextField(controller: _cursoController, decoration: const InputDecoration(labelText: "Curso")),
            TextField(controller: _cidadeController, decoration: const InputDecoration(labelText: "Cidade")),
            TextField(controller: _paisController, decoration: const InputDecoration(labelText: "País")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _salvarDados, child: const Text("Salvar")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _voltarLogin, child: const Text("Voltar")),
          ],
        ),
      ),
    );
  }
}
