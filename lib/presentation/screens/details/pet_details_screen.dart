import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_app/blocs/pets/pets_bloc.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/presentation/widgets/dialog_with_celebration_widget.dart';
import 'package:nymble_app/presentation/widgets/responsive_wrapper_widget.dart';

class PetDetailsScreen extends StatelessWidget {
  final String name;
  final PetsModel petDetails;
  const PetDetailsScreen({
    super.key,
    required this.name,
    required this.petDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    const sizedBoxHeight05 = SizedBox(height: 05);
    const sizedBoxHeightSection = SizedBox(height: 15);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [buildAppBar(context)];
        },
        body: SizedBox(
          child: ResponsiveWrapperWidget(
            verticalPadding: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImageAndDetails(
                    context, mediaQuery, theme, sizedBoxHeight05),
                sizedBoxHeightSection,
                Text(
                  "Details",
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizedBoxHeight05,
                Row(
                  children: [
                    buildAttribute(theme, "Sex", petDetails.gender),
                    buildAttribute(theme, "Age", petDetails.age),
                    buildAttribute(theme, "Breed", petDetails.breed)
                  ],
                ),
                sizedBoxHeightSection,
                Text(
                  petDetails.detail,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall!.color!.withAlpha(150),
                  ),
                ),
                sizedBoxHeightSection,
                Container(
                  alignment: Alignment.center,
                  child: adoptDogButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildImageAndDetails(
    BuildContext context,
    MediaQueryData mediaQuery,
    ThemeData theme,
    SizedBox sizedBoxHeight05,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: GestureDetector(
              child: Hero(
                tag: petDetails.image,
                child: CachedNetworkImage(
                  imageUrl: petDetails.image,
                  fit: BoxFit.cover,
                  height: mediaQuery.size.height * 0.3,
                  width: mediaQuery.size.width * 0.3,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: InteractiveViewer(
                        child: CachedNetworkImage(
                          imageUrl: petDetails.image,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                petDetails.name,
                style: theme.textTheme.headlineLarge,
              ),
              Text(
                "₹${petDetails.price}",
                style: theme.textTheme.headlineSmall!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              sizedBoxHeight05,
              Row(
                children: [
                  Icon(
                    Icons.pin_drop_outlined,
                    size: theme.textTheme.bodyMedium!.fontSize,
                    color: theme.textTheme.bodySmall!.color!.withAlpha(150),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    petDetails.location,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.textTheme.bodySmall!.color!.withAlpha(150),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  buildAttribute(ThemeData theme, title, detail) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.textTheme.bodySmall!.color!.withAlpha(150),
            ),
          ),
          const SizedBox(height: 3),
          Text(detail),
        ],
      ),
    );
  }

  adoptDogButton(BuildContext context) {
    return FilledButton.tonal(
      child: Text("Adopt ${petDetails.name}"),
      onPressed: () {
        context.read<PetsBloc>().add(
              PetsModifyEvent(
                id: petDetails.id!,
                isAdopted: true,
                onSuccess: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialodWithCelebration(
                        title: "You’ve now adopted ${petDetails.name}",
                        content: "${petDetails.name} adoption request has been "
                            "sent to use, we will get back to you soon!!!",
                      );
                    },
                    barrierDismissible: false,
                  );
                },
              ),
            );
      },
    );
  }

  buildAppBar(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
          pinned: true,
          title: Text("About ${petDetails.name}"),
          centerTitle: false,
        ),
      ),
    );
  }
}
