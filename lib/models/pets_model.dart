// To parse this JSON data, do
//
//     final petsModel = petsModelFromJson(jsonString);

import 'dart:convert';

List<PetsModel> petsModelFromJson(String str) =>
    List<PetsModel>.from(json.decode(str).map((x) => PetsModel.fromJson(x)));

String petsModelToJson(List<PetsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetsModel {
  PetsModel({
    this.id,
    required this.name,
    required this.age,
    this.adopted,
    required this.price,
    required this.breed,
    required this.image,
    required this.location,
    required this.gender,
    required this.detail,
  });

  late String? id;
  final String name;
  final String age;
  final bool? adopted;
  final String price;
  final String breed;
  final String image;
  final String location;
  final String gender;
  final String detail;

  factory PetsModel.fromJson(Map<String, dynamic> json) => PetsModel(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        adopted: json["adopted"],
        price: json["price"],
        breed: json["breed"],
        image: json["image"],
        location: json["location"],
        gender: json["gender"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "adopted": adopted,
        "price": price,
        "breed": breed,
        "image": image,
        "location": location,
        "gender": gender,
        "detail": detail,
      };

  // factory PetsModel.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   final name = data['name'] as String;
  //   final breed = data['breed'] as String;
  //   final image = data['image'] as String;
  //   final age = data['age'] as String;
  //   final gender = data['gender'] as String;
  //   final adopted = data['adopted'] as bool;
  //   final location = data['location'] as String;
  //   final price = data['adopted'] as String;

  //   return PetsModel(
  //     name: name,
  //     breed: breed,
  //     image: image,
  //     adopted: adopted,
  //     age: age,
  //     gender: gender,
  //     location: location,
  //     price: price,
  //   );
  // }
}
