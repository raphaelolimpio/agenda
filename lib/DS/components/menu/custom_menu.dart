import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  final Function(String) onItemSelected;

  const CustomMenu({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onItemSelected, // Passando a função de navegação aqui
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: "profile",
            child: Text("Perfil"),
          ),
          const PopupMenuItem<String>(
            value: "settings",
            child: Text("Configurações"),
          ),
          const PopupMenuItem<String>(
            value: "logout",
            child: Text("Sair"),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
