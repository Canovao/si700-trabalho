import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/AuthBloc.dart';
import 'package:si700_trabalho/bloc/LoginBloc.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextNoStyleLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

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
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              child: BaseTextNoStyleLayout(text: 'Login'),
            ),
            TextButton(
              onPressed: () => _createAccount(context),
              child: BaseTextNoStyleLayout(
                text: 'Não tem uma conta? Criar conta',
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (_emailController.text == '' || _passwordController.text == '') {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BaseTextLayout(
                    text: 'Preencha todos os campos!',
                    textAlign: TextAlign.center),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const BaseTextNoStyleLayout(text: 'Ok'),
                ),
              ],
            ),
          ),
        ),
      );
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(LoginUser(
      username: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _createAccount(context) {
    BlocProvider.of<LoginBloc>(context).add(LoginEvent.CreateAccount);
  }
}
