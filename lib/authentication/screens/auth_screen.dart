import 'package:flutter/material.dart';
import 'package:flutter_listin/_core/constants/listin_colors.dart';
import 'package:flutter_listin/authentication/screens/widgets/show_custom_snackbar.dart';
import 'package:flutter_listin/authentication/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // TODO: Ao implementar autenticação, remover valores mockados.
  final TextEditingController _emailController =
      TextEditingController(text: "ricarth.lima@alura.com.br");
  final TextEditingController _senhaController =
      TextEditingController(text: "123321");
  final TextEditingController _confirmaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  bool isEntrando = true;

  final _formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (isEntrando)
                            ? "Boas-vindas ao Listin!"
                            : "Vamos começar?",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      (isEntrando)
                          ? "Faça login para criar sua lista de compras."
                          : "Faça seu cadastro para começar a criar sua lista de compras com Listin.",
                      textAlign: TextAlign.center,
                    ),
                    Visibility(
                      visible: !isEntrando,
                      child: TextFormField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          label: Text("Nome"),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Insira um nome maior.";
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(label: Text("E-mail")),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "O valor de e-mail deve ser preenchido";
                        }
                        if (!value.contains("@") ||
                            !value.contains(".") ||
                            value.length < 4) {
                          return "O valor do e-mail deve ser válido";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: const InputDecoration(label: Text("Senha")),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return "Insira uma senha válida.";
                        }
                        return null;
                      },
                    ),
                    Visibility(
                      visible: isEntrando,
                      child: TextButton(
                        onPressed: () {
                          esqueciMinhaSenhaClicado();
                        },
                        child: const Text("Esqueci minha senha"),
                      ),
                    ),
                    Visibility(
                      visible: !isEntrando,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _confirmaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text("Confirme a senha"),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 4) {
                                return "Insira uma confirmação de senha válida.";
                              }
                              if (value != _senhaController.text) {
                                return "As senhas devem ser iguais.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ListinColors.purple),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        botaoEnviarClicado();
                      },
                      child: Text(
                        (isEntrando) ? "Entrar" : "Cadastrar",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEntrando = !isEntrando;
                        });
                      },
                      child: Text(
                        (isEntrando)
                            ? "Ainda não tem conta? Clique aqui para cadastrar."
                            : "Já tem conta? Clique aqui para entrar.",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  botaoEnviarClicado() {
    String email = _emailController.text;
    String senha = _senhaController.text;
    String nome = _nomeController.text;

    if (_formKey.currentState!.validate()) {
      if (isEntrando) {
        _entrarUsuario(email: email, senha: senha);
      } else {
        _criarUsuario(email: email, senha: senha, nome: nome);
      }
    }
  }

  _entrarUsuario({required String email, required String senha}) {
    // TODO: Ao implementar autenticação remover snackbar mockado.
    showCustomSnackBar(
      context: context,
      message: "TODO: Login com e-mail e senha.",
      isError: false,
      showContinue: true,
    );
  }

  _criarUsuario({
    // TODO: Ao implementar autenticação remover snackbar mockado.
    required String email,
    required String senha,
    required String nome,
  }) {
    showCustomSnackBar(
      context: context,
      message: "TODO: Cadastro de nova conta.",
      isError: false,
      showContinue: true,
    );
  }

  esqueciMinhaSenhaClicado() {
    String email = _emailController.text;
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController redefincaoSenhaController =
            TextEditingController(text: email);
        return AlertDialog(
          title: const Text("Confirme o e-mail para redefinição de senha"),
          content: TextFormField(
            controller: redefincaoSenhaController,
            decoration: const InputDecoration(label: Text("Confirme o e-mail")),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          actions: [
            TextButton(
              onPressed: () {
                showCustomSnackBar(
                  context: context,
                  message: "E-mail de redefinição enviado!",
                  isError: false,
                );
                Navigator.pop(context);
              },
              child: const Text("Redefinir senha"),
            ),
          ],
        );
      },
    );
  }
}
