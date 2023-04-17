import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/globals/const/global_assets.dart';
import 'package:nymble_app/routers/routes.dart';

class NoDogsAdoptedWidget extends StatelessWidget {
  const NoDogsAdoptedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              GlobalLocalAssets.noDogsAdoptedHeading,
              style: textTheme.headlineSmall!.copyWith(
                color: textTheme.headlineSmall!.color!.withAlpha(150),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              GlobalLocalAssets.noDogsAdoptedText,
              style: textTheme.bodyMedium!.copyWith(
                color: textTheme.bodyMedium!.color!.withAlpha(150),
              ),
            ),
            const SizedBox(height: 15),
            CachedNetworkImage(
              imageUrl: GlobalNetworkAssets.noDogsAdopted,
              placeholder: (context, url) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
              width: size.width * 0.5,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(height: 15),
            FilledButton.tonal(
              child: const Text("Adopte now"),
              onPressed: () => context.go(homeRoute),
            )
          ],
        ),
      ),
    );
  }
}
