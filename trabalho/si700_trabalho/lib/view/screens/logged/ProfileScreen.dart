import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/AccountBloc.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextNoStyleLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenSubTitleTextLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AccountBloc _accountBloc = AccountBloc();
  ProfileScreen({super.key});

  _getUserData() {
    // TODO IMPLEMENTAR UMA LÓGICA DE VERDADE PRA MOSTRAR OS DADOS DO USUÁRIO
    return Column(children: [
      ScreenTitleTextlayout(text: ProfileContent.self!.name),
      BaseTextLayout(
        text: ProfileContent.self!.email,
      ),
      BaseTextLayout(
        text: ProfileContent.self!.phone,
      )
    ]);
  }

  _buildFavorites() {
    // TODO IMPLEMENTAR UMA LÓGICA DE VERDADE PRA MOSTRAR OS FAVORITOS DO USUÁRIO
    return Column(
      children: ProfileContent.self!.favoritePlaces
          .map((e) => BaseTextLayout(text: e))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: _accountBloc,
      builder: (BuildContext context, state) {
        switch (state) {
          case AccountState.Idle:
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ScreenTitleTextlayout(text: 'Perfil'),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _accountBloc.add(AccountEvent.Editing);
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    _getUserData(),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, color: Colors.black),
                        TextButton(
                            onPressed: () {
                              _accountBloc.add(AccountEvent.Favorites);
                            },
                            child: BaseTextLayout(text: 'Favoritos'))
                      ],
                    )
                  ],
                ),
              ),
            );
          case AccountState.Editing:
            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          _accountBloc.add(AccountEvent.Idle);
                        },
                      ),
                      ScreenTitleTextlayout(text: 'Editar perfil'),
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          // TODO IMPLEMENTAR LÓGICA DE SALVAR DADOS ALTERADOS
                          ProfileContent profileContent =
                              ProfileContent.fromAnother(
                                  another: ProfileContent.self!,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text);

                          // TODO SALVAR OS DADOS

                          ProfileContent.self = profileContent;

                          _accountBloc.add(AccountEvent.Idle);
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
                                        text: 'Dados alterados com sucesso!',
                                        textAlign: TextAlign.center),
                                    SizedBox(height: 15),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const BaseTextNoStyleLayout(
                                          text: 'Ok'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: ProfileContent.self!.name,
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: ProfileContent.self!.email,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      hintText: ProfileContent.self!.phone,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ])));
          case AccountState.Favorites:
            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: [
                  Row(children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _accountBloc.add(AccountEvent.Idle);
                      },
                    ),
                  ]),
                  ScreenTitleTextlayout(text: 'Favoritos'),
                  _buildFavorites()
                ])));
          case AccountState.History:
            return const Text('History');
        }
      },
    );
  }
}
