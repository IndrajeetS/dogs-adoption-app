import 'package:flutter/material.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/presentation/widgets/pet_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = PetsModel(
      id: "",
      adopted: false,
      age: "11 years",
      breed: "Labradore",
      gender: "male",
      image: "",
      location: "Delhi, India",
      name: "Maxi",
      price: "5000/-",
      detail: "",
    );
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey,
            child: PetItemWidget(petData: pets),
          );
        },
        itemCount: 2,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}
