import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/routers/routes.dart';

class MenuDropDownWidget extends StatelessWidget {
  const MenuDropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'new_dog',
          child: const Text('Add Dog'),
          onTap: () => context.push(addNewDogRoute),
        ),
        PopupMenuItem(
          value: 'pet_timeline',
          child: const Text('Pets Timeline'),
          onTap: () => context.push(historyRoute),
        ),
        // PopupMenuItem(
        //   value: 'theme_toggle',
        //   child: const Text('Dark Mode'),
        //   onTap: () => context.go(historyRoute),
        // ),
      ],
    );
  }
}
