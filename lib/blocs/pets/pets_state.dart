part of 'pets_bloc.dart';

// --------------------------------------
// Initial abstract class for
// PetState extending Equatable
// --------------------------------------
abstract class PetsState extends Equatable {
  const PetsState();
  @override
  List<Object> get props => [];
}

// --------------------------------------
// Pets Loading State -> Initial State
// --------------------------------------
class PetsLoadingState extends PetsState {
  const PetsLoadingState();
}

// --------------------------------------
// Pets Loaded State ->
// Pasing the List<PetsModel>
// --------------------------------------
class PetsLoadedState extends PetsState {
  final Future<List<PetsModel>> pets;

  const PetsLoadedState(this.pets);
  @override
  List<Object> get props => [pets];
}

// --------------------------------------
// Pets Error State while loading
// --------------------------------------
class PetsErrorState extends PetsState {
  final String e;
  const PetsErrorState(this.e);
  @override
  List<Object> get props => [e];
}
