import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/provider/ProfileContentProvider.dart';
import 'package:si700_trabalho/view/layout/ProfileIconSelectorLayout.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextNoStyleLayout.dart';
import 'package:si700_trabalho/view/layout/text/ScreenTitleTextLayout.dart';

class Editingprofilescreen extends StatefulWidget {
  Editingprofilescreen({super.key});

  @override
  State<Editingprofilescreen> createState() => _EditingprofilescreenState();
}

class _EditingprofilescreenState extends State<Editingprofilescreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  String? selectedProfileIcon = ProfileContent.self!.profileIcon;

  bool receiveNotifications = ProfileContent.self!.receiveNotifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                    Navigator.pop(context);
                  },
                ),
                ScreenTitleTextlayout(text: 'Editar perfil'),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    ProfileContent profileContent = ProfileContent.fromAnother(
                        another: ProfileContent.self!,
                        name: _nameController.text,
                        email: ProfileContent.self!.email,
                        phone: _phoneController.text,
                        profileIcon: selectedProfileIcon ??
                            ProfileContent.self!.profileIcon,
                        receiveNotifications: receiveNotifications);

                    ProfileContentProvider.helper.update(profileContent);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            ProfileIconSelectorLayout(
              whenSelectIcon: (String str) {
                selectedProfileIcon = str;
              },
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
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
                hintText: ProfileContent.self!.phone,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            Row(
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
            )
          ]))),
    );
  }
}
