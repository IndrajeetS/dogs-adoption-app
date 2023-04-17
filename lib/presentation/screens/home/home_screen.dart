import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/blocs/pets/pets_bloc.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/presentation/widgets/menu_dropdown_widget.dart';
import 'package:nymble_app/presentation/widgets/pet_item_widget.dart';
import 'package:nymble_app/presentation/widgets/responsive_wrapper_widget.dart';
import 'package:nymble_app/presentation/widgets/shimmer_list_widget.dart';
import 'package:nymble_app/presentation/widgets/theme_switch_widget.dart';
import 'package:nymble_app/routers/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // -------------------------------------
  // Declare variable for searchbar
  // -------------------------------------
  final _searchTextController = TextEditingController();
  String _searchQuery = '';

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [buildAppBar(context)];
        },
        body: SizedBox(
          height: mediaQuery.size.height - kToolbarHeight,
          child: ResponsiveWrapperWidget(
            verticalPadding: true,
            child: Column(
              children: [
                // const SearchBar(),
                buildSearchBar(
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                    log("_searchQuery --> $_searchQuery");
                  },
                ),
                const SizedBox(height: 15),
                Expanded(child: buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: const SliverSafeArea(
        top: false,
        sliver: SliverSafeArea(
          top: false,
          sliver: SliverAppBar(
            title: Text("Adopt a 🐶"),
            pinned: true,
            floating: true,
            centerTitle: false,
            actions: [
              ThemeSwitchWidget(),
              MenuDropDownWidget(),
            ],
          ),
        ),
      ),
    );
  }

  buildBody() {
    return BlocProvider(
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
          final newFilteredList = snapshot.data!.where((pet) {
            final petName = pet.name.toLowerCase();
            final searchQuery = _searchQuery.toLowerCase();
            return petName.contains(searchQuery);
          }).toList();
          return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: newFilteredList.length,
            itemBuilder: (context, index) {
              final indexPet = newFilteredList[index];
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
                        context.push(
                          "$petDetailRoute/$lowerCaseName",
                          extra: indexPet,
                        );
                      },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15);
            },
          );
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

  buildSearchBar({
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search dogs...',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () => controller!.clear(),
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
