part of 'pets_bloc.dart';

// --------------------------------------
// Initial abstract class for
// PetEvent extending Equatable
// --------------------------------------
abstract class PetsEvent extends Equatable {
  const PetsEvent();
  @override
  List<Object> get props => [];
}

// --------------------------------------
// Pets Loaded Event
// --------------------------------------
class PetsLoadedEvent extends PetsEvent {
  const PetsLoadedEvent();
  @override
  List<Object> get props => [];
}

// -------------------------------------------
// Modify Existing Pet Event ->
// To make isAdopted true for ped using ID
// -------------------------------------------
class PetsModifyEvent extends PetsEvent {
  final String id;
  final bool isAdopted;
  final VoidCallback onSuccess;
  const PetsModifyEvent({
    required this.id,
    required this.isAdopted,
    required this.onSuccess,
  });
}

// -------------------------------------------
// Add New Pet Event ->
// To make isAdopted true for ped using ID
// -------------------------------------------
class AddNewPetEvent extends PetsEvent {
  final PetsModel addNewPet;
  final VoidCallback onSuccess;
  const AddNewPetEvent({
    required this.addNewPet,
    required this.onSuccess,
  });
}
