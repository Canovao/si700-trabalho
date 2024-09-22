import 'package:flutter/material.dart';
import 'package:si700_trabalho/bloc/LoginBloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextNoStyleLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc loginBloc;

  LoginScreen({super.key, required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScreenTitleTextlayout(
              text: 'Login',
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'exemplo@email.com',
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: '********',
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              child: BaseTextNoStyleLayout(text: 'Login'),
            ),
            TextButton(
              onPressed: () => _createAccount(),
              child: BaseTextNoStyleLayout(
                text: 'Não tem uma conta? Criar conta',
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() {
    // TODO FAZER O LOGIN
    print('Email: ${_emailController.text}');
    print('Senha: ${_passwordController.text}');

    // TODO PUXAR O PROFILECONTENT DO BANCO e colocar no self

    // FIXME linha abaixo é mock
    ProfileContent.self = ProfileContent(
      name: 'Leonardo',
      email: 'email@exemplo.com',
      phone: '19999998888',
      profileIcon: '',
      password: '',
      receiveNotifications: false,
      favoritePlaces: List.of(['lugar1', 'lugar2']),
    );

    // TODO E DEPOIS DE FAZER O LOGIN, AÍ SIM MANDAR O EVENTO, mas por enquanto passa direto

    loginBloc.add(LoginEvent.Login);
  }

  void _createAccount() {
    loginBloc.add(LoginEvent.CreateAccount);
  }
}
