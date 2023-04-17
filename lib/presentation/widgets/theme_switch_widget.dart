import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_app/blocs/theme/theme_bloc.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch.adaptive(
          value: state.switchValue,
          onChanged: (val) {
            val
                ? context.read<ThemeBloc>().add(ThemeOnEvent())
                : context.read<ThemeBloc>().add(ThemeOffEvent());
          },
        );
      },
    );
  }
}
