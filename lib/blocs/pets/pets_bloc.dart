import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/repositories/pets/pets_repository.dart';

part 'pets_event.dart';
part 'pets_state.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  PetsBloc() : super(const PetsLoadingState()) {
    // -------------------------------------
    // Fetch all the pets from
    // Firebase on PetsLoadedEvent
    // -------------------------------------
    on<PetsLoadedEvent>((event, emit) {
      emit(const PetsLoadingState());
      try {
        final Future<List<PetsModel>> pets = PetsRepository().fetchPets();
        emit(PetsLoadedState(pets));
      } catch (e) {
        emit(PetsErrorState(e.toString()));
      }
    });

    // -------------------------------------
    // Update adopted field in firebase
    // -------------------------------------
    on<PetsModifyEvent>((event, emit) {
      emit(const PetsLoadingState());
      try {
        final Future<List<PetsModel>> updatePet = PetsRepository().modifyPet(
          id: event.id,
          isAdopted: event.isAdopted,
          onSuccess: event.onSuccess,
        );
        emit(PetsLoadedState(updatePet));
      } catch (e) {
        emit(PetsErrorState(e.toString()));
      }
    });

    on<AddNewPetEvent>((event, emit) {
      emit(const PetsLoadingState());
      try {
        final Future<List<PetsModel>> updatePet = PetsRepository().addNewPet(
          pet: event.addNewPet,
          onSuccess: event.onSuccess,
        );
        emit(PetsLoadedState(updatePet));
      } catch (e) {
        emit(PetsErrorState(e.toString()));
      }
    });
  }
}
