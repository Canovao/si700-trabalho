import 'package:flutter/material.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/model/ProfileIcons.dart';

class ProfileIconSelectorLayout extends StatefulWidget {
  Function(String) whenSelectIcon;
  String? selectedProfileIcon =
      (ProfileContent.self != null) ? ProfileContent.self!.profileIcon : null;
  ProfileIconSelectorLayout({required this.whenSelectIcon, super.key});

  @override
  State<ProfileIconSelectorLayout> createState() =>
      _ProfileIconSelectorLayoutState();
}

class _ProfileIconSelectorLayoutState extends State<ProfileIconSelectorLayout> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _chooseProfileIcon(context, (icon) {
        setState(() {
          widget.whenSelectIcon(icon);
          widget.selectedProfileIcon = icon;
        });
      }),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: widget.selectedProfileIcon != null
            ? AssetImage(widget.selectedProfileIcon!)
            : null,
        child: widget.selectedProfileIcon == null
            ? Icon(Icons.person, size: 50, color: Colors.grey)
            : null,
      ),
    );
  }
}
