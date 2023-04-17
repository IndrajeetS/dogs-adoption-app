import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nymble_app/models/pets_model.dart';

class PetItemWidget extends StatelessWidget {
  final PetsModel petData;
  final void Function()? onTap;
  const PetItemWidget({
    super.key,
    required this.petData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(15);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
          onTap: onTap,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              petData.adopted! ? Colors.grey.shade400 : Colors.transparent,
              BlendMode.saturation,
            ),
            child: buildInnerBody(borderRadius, theme, context),
          )),
    );
  }

  buildInnerBody(
    BorderRadius borderRadius,
    ThemeData theme,
    BuildContext context,
  ) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: mediaQuery.size.width * 0.3,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              child: petData.image == ""
                  ? Placeholder(
                      fallbackWidth: mediaQuery.size.width * 0.3,
                      fallbackHeight: 150,
                    )
                  : Hero(
                      tag: petData.image,
                      child: CachedNetworkImage(
                        imageUrl: petData.image,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    petData.name,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LayoutBuilder(builder: (context, constrains) {
                    if (constrains.maxWidth < 600) {
                      return Wrap(children: listOfAttributes(context));
                    } else {
                      return Row(children: listOfAttributes(context));
                    }
                  }),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        color: theme.primaryColor,
                        size: theme.textTheme.bodyMedium!.fontSize,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        petData.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.textTheme.bodySmall!.color!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        petData.adopted!
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Card(
                  color: theme.colorScheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      "Adopted",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onError,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  listOfAttributes(context) {
    return <Widget>[
      buildAttribute(
        context: context,
        icon: petData.gender == "Male" ? Icons.male : Icons.female,
        info: petData.gender,
      ),
      SizedBox(width: 3),
      buildAttribute(
        context: context,
        icon: Icons.calendar_month,
        info: petData.age,
      ),
      SizedBox(width: 3),
      buildAttribute(
        context: context,
        icon: Icons.currency_rupee,
        info: petData.price,
      ),
    ];
  }

  buildAttribute({
    required BuildContext context,
    IconData? icon,
    String? info,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          // color: textTheme.bodyMedium!.color!.withAlpha(150),
          color: theme.primaryColor,
          size: textTheme.bodyMedium!.fontSize,
        ),
        const SizedBox(width: 5),
        Text(
          info!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodySmall!.copyWith(
            color: textTheme.bodySmall!.color!,
          ),
        ),
      ],
    );
  }
}




// return InkWell(
// onTap: onTap,
// borderRadius: borderRadius,
// child: Ink(
//   width: double.infinity,
//   decoration: BoxDecoration(
//     color: theme.scaffoldBackgroundColor.withAlpha(200),
//     borderRadius: borderRadius,
//     boxShadow: const [
//       BoxShadow(
//         color: Color(0xffDDDDDD),
//         blurRadius: 1.0,
//         spreadRadius: 0.0,
//         offset: Offset(0.0, 2.0),
//       )
//     ],
//   ),
//   child: buildInnerBody(borderRadius, theme, context),
// ),
// );