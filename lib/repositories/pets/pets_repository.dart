import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nymble_app/models/pets_model.dart';

class PetsRepository {
  final _dogsCollection = FirebaseFirestore.instance.collection('dogs');

  // ----------------------------------------------------
  // Fetch all the Pets and convert the
  // snapshot in Json to pass it with Model class
  // ----------------------------------------------------
  Future<List<PetsModel>> fetchPets() async {
    final List<Map<String, dynamic>> dogsListJson = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _dogsCollection.get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in snapshot.docs) {
        dogsListJson.add(documentSnapshot.data());
      }
      List<PetsModel> petsList = dogsListJson.map((petJson) {
        return PetsModel.fromJson(petJson);
      }).toList();

      return petsList;
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        log("Error loading pets ${error.code} & ${error.message}");
      }
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }

  // ----------------------------------------------------
  // Update "adopted" Field in Specific Document
  // ----------------------------------------------------
  Future<List<PetsModel>> modifyPet({
    required String id,
    required bool isAdopted,
    required VoidCallback onSuccess,
  }) async {
    final List<Map<String, dynamic>> dogsListJson = [];
    List<PetsModel> petsList = [];
    try {
      await _dogsCollection.doc(id).update({"adopted": isAdopted}).then(
        (value) async {
          QuerySnapshot<Map<String, dynamic>> snapshot =
              await _dogsCollection.get();

          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
              in snapshot.docs) {
            dogsListJson.add(documentSnapshot.data());
          }
          petsList = dogsListJson.map((petJson) {
            return PetsModel.fromJson(petJson);
          }).toList();
        },
        onError: (e) {
          log("Error updating pet $e");
          throw Exception(e);
        },
      );
      onSuccess();
      return petsList;
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        log(error.message.toString());
      }
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }

  // ------------------------------
  // Add new pet function
  // ------------------------------
  addNewPet({
    required PetsModel pet,
    required VoidCallback onSuccess,
  }) async {
    try {
      DocumentReference docRef = await _dogsCollection.add({
        "id": '',
        "name": pet.name,
        "age": pet.age,
        "breed": pet.breed,
        "image": pet.image,
        "location": pet.location,
        "gender": pet.gender,
        "price": pet.price,
        "adopted": false,
        "detail": pet.detail,
      });
      String docId = docRef.id;
      pet.id = docId;
      await docRef.update({'id': docId});
      onSuccess();
    } catch (e) {
      throw Exception(e);
    }
  }
}





// Future<List<PetsModel>> fetchAllPets() async {
//     List<PetsModel> petsList = [];

//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot =
//           await _dogsCollection.get();

//       for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
//           in snapshot.docs) {
//         _dogsListJson.add(documentSnapshot.data());
//       }
//       List<PetsModel> petsList = _dogsListJson.map((petJson) {
//         return PetsModel.fromJson(petJson);
//       }).toList();

//       return petsList;
//     } on FirebaseException catch (error) {
//       if (kDebugMode) {
//         log(error.message.toString());
//       }
//       throw Exception(error);
//     } catch (error) {
//       throw Exception(error);
//     }
//   }