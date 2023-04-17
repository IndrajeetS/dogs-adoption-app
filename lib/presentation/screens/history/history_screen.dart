import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/blocs/pets/pets_bloc.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/presentation/widgets/menu_dropdown_widget.dart';
import 'package:nymble_app/presentation/widgets/no_dogs_widgets.dart';
import 'package:nymble_app/presentation/widgets/pet_item_widget.dart';
import 'package:nymble_app/presentation/widgets/responsive_wrapper_widget.dart';
import 'package:nymble_app/presentation/widgets/shimmer_list_widget.dart';
import 'package:nymble_app/routers/routes.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: const Text("Pets History"),
                    pinned: true,
                    floating: true,
                    centerTitle: false,
                    backgroundColor: theme.scaffoldBackgroundColor,
                    actions: const [MenuDropDownWidget()],
                    automaticallyImplyLeading: true,
                  ),
                ),
              ),
            )
          ];
        },
        body: SizedBox(
          height: mediaQuery.size.height - kToolbarHeight,
          child: ResponsiveWrapperWidget(
            verticalPadding: true,
            child: buildBody(),
          ),
        ),
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) {
          return PetsBloc()..add(const PetsLoadedEvent());
        },
        child: BlocBuilder<PetsBloc, PetsState>(
          builder: (context, state) {
            if (state is PetsLoadingState) {
              return const ShimmerList();
            }
            if (state is PetsErrorState) {
              return Center(child: SelectableText(state.e.toString()));
            }
            if (state is PetsLoadedState) {
              final Future<List<PetsModel>> petsData = state.pets;
              return buildFutureBuilder(
                context: context,
                petsData: petsData,
              );
            }
            return Text(state.toString());
          },
        ),
      ),
    );
  }

  buildFutureBuilder({
    required Future<List<PetsModel>> petsData,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    return FutureBuilder(
      future: petsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerList();
        }
        if (snapshot.hasData) {
          final filterAdoptedDogs =
              snapshot.data!.where((element) => element.adopted!).toList();
          return filterAdoptedDogs.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: filterAdoptedDogs.length,
                  itemBuilder: (context, index) {
                    final indexPet = filterAdoptedDogs[index];
                    final lowerCaseName = indexPet.name.toLowerCase();
                    return PetItemWidget(
                      petData: indexPet,
                      onTap: indexPet.adopted!
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: theme.colorScheme.error,
                                  content: Text(
                                    "${indexPet.name} has been adopted",
                                    style: TextStyle(
                                      color: theme.colorScheme.onError,
                                    ),
                                  ),
                                ),
                              );
                            }
                          : () {
                              context.go(
                                "$petDetailRoute/$lowerCaseName",
                                extra: indexPet,
                              );
                            },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                )
              : const NoDogsAdoptedWidget();
        } else if (snapshot.hasError) {
          return Center(
            child: SelectableText(
              snapshot.error.toString(),
            ),
          );
        } else {
          return ShimmerList(key: GlobalKey());
        }
      },
    );
  }
}
