import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/AuthBloc.dart';
import 'package:si700_trabalho/bloc/LoginBloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/model/ProfileIcons.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextNoStyleLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class CreateAccountScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc loginBloc;

  // TODO ADICIONAR ÍCONES DE VERDADE NO PROJETO

  void _chooseProfileIcon(
      BuildContext context, Function(String) onIconSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
            ),
            itemCount: ProfileIcons.profileIcons.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onIconSelected(ProfileIcons.profileIcons[index]);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage(ProfileIcons.profileIcons[index]),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  CreateAccountScreen({super.key, required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    bool receiveNotifications = false;
    String? selectedProfileIcon;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    loginBloc.add(LoginEvent.NotLogged);
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            ScreenTitleTextlayout(text: 'Criar conta'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _chooseProfileIcon(context, (icon) {
                selectedProfileIcon = icon;
              }),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: selectedProfileIcon != null
                    ? AssetImage(selectedProfileIcon)
                    : null,
                child: selectedProfileIcon == null
                    ? Icon(Icons.person, size: 50, color: Colors.grey)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome completo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'email@exemplo.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
                hintText: '(99) 99999-9999',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: '********',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseTextNoStyleLayout(
                      text: 'Deseja receber notificações por e-mail?',
                    ),
                    Switch(
                      value: receiveNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          receiveNotifications = value;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _createAccount(
                  receiveNotifications, selectedProfileIcon, context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              child: BaseTextLayout(text: 'Criar conta'),
            ),
          ],
        ),
      ),
    );
  }

  void _createAccount(bool receiveNotifications, String? selectedProfileIcon,
      BuildContext context) {
    // TODO CRIAR CONTA
    print('Nome: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Telefone: ${_phoneController.text}');
    print('Senha: ${_passwordController.text}');
    print('Receber notificações por e-mail: $receiveNotifications');
    print('Ícone de perfil selecionado: $selectedProfileIcon');

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

    ProfileContent profileContent = ProfileContent(
      profileIcon: selectedProfileIcon ?? '',
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      receiveNotifications: receiveNotifications,
    );

    BlocProvider.of<AuthBloc>(context).add(RegisterUser(
      profileContent: profileContent,
      username: _emailController.text,
      password: _passwordController.text,
    ));

    loginBloc.add(LoginEvent.NotLogged);
  }
}
