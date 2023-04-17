import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/presentation/screens/add-new/add_new_dog_screen.dart';
import 'package:nymble_app/presentation/screens/details/pet_details_screen.dart';
import 'package:nymble_app/presentation/screens/history/history_screen.dart';
import 'package:nymble_app/presentation/screens/home/home_screen.dart';
import 'package:nymble_app/routers/routes.dart';

class AppRouter {
  // ------------------------------------
  // Declare GlobalKey For navigatorKey
  // ------------------------------------
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  // ------------------------------------
  // Getter for GoRouter Instance
  // ------------------------------------
  GoRouter get getRouter => _router;

  static final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: homeRoute,
        name: 'Home',
        builder: (context, state) => HomeScreen(key: state.pageKey),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: "$petDetailRoute/:name",
        name: 'Pet Details',
        builder: (context, state) {
          final extra = state.extra as PetsModel;
          return PetDetailsScreen(
            key: state.pageKey,
            name: state.params['name']!,
            petDetails: extra,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: historyRoute,
        name: 'Pets Timeline',
        builder: (context, state) => HistoryScreen(key: state.pageKey),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: addNewDogRoute,
        name: 'Add new dog',
        builder: (context, state) => AddNewDogScreen(key: state.pageKey),
      ),
    ],
  );
}
