import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nymble_app/blocs/pets/pets_bloc.dart';
import 'package:nymble_app/globals/const/global_assets.dart';
import 'package:nymble_app/models/pets_model.dart';
import 'package:nymble_app/presentation/widgets/responsive_wrapper_widget.dart';

class AddNewDogScreen extends StatefulWidget {
  const AddNewDogScreen({super.key});

  @override
  State<AddNewDogScreen> createState() => _AddNewDogScreenState();
}

class _AddNewDogScreenState extends State<AddNewDogScreen> {
  // -------------------------------------------------
  // TextField Variable to collect New Pets Details
  // -------------------------------------------------
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailsController = TextEditingController();

  // ---------------------------------------------
  // Scaffold & form key, to check
  // input feilds before form subbmission
  // ---------------------------------------------
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formStateKey = GlobalKey<FormState>();

  // Varaible for Gender Selection
  dynamic _selectedGender;

  @override
  Widget build(BuildContext context) {
    const sizedBoxHeight = SizedBox(height: 15);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [buildAppBar(context)];
        },
        body: SizedBox(
          height: kToolbarHeight,
          child: SingleChildScrollView(
            child: ResponsiveWrapperWidget(
              verticalPadding: true,
              child: Form(
                key: _formStateKey,
                child: Column(
                  children: [
                    Text(
                      GlobalLocalAssets.newDogForAdoptionText,
                      style: textTheme.bodyMedium!.copyWith(
                        color: textTheme.bodyMedium!.color!.withAlpha(120),
                      ),
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _nameController,
                      hintText: "Name of the Dog",
                      prefixIcon: const Icon(Icons.person),
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _ageController,
                      hintText: "How old dog is?",
                      prefixIcon: const Icon(Icons.calendar_view_day),
                      keyboardType: TextInputType.number,
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _breedController,
                      hintText: "Enter the breed",
                      prefixIcon: const Icon(Icons.category),
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _priceController,
                      hintText: "Price for support",
                      prefixIcon: const Icon(Icons.price_change_outlined),
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _locationController,
                      hintText: "Place where dog is currently",
                      prefixIcon: const Icon(Icons.pin_drop),
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _imageController,
                      hintText: "Add image URL of a dog",
                      prefixIcon: const Icon(Icons.image_outlined),
                    ),
                    sizedBoxHeight,
                    buildInputField(
                      controller: _detailsController,
                      hintText: "Some information about the dog",
                      maxLines: 5,
                    ),
                    sizedBoxHeight,
                    buildRadioButtonGroup(context),
                    sizedBoxHeight,
                    FilledButton.tonal(
                      child: const Text("Submit Details"),
                      onPressed: () {
                        if (_formStateKey.currentState!.validate()) {
                          _addNewPetFunction();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text("Please provide all the details"),
                              backgroundColor: theme.colorScheme.error,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildRadioButtonGroup(
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: buildRadioButton(
            context: context,
            title: 'Male',
            value: 'Male',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: buildRadioButton(
            context: context,
            title: 'Female',
            value: 'Female',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  buildAppBar(
    BuildContext context,
  ) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
          leading: IconButton(
            icon: Icon(Icons.adaptive.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text("Add New"),
          centerTitle: false,
          pinned: true,
          floating: true,
        ),
      ),
    );
  }

  buildInputField({
    TextEditingController? controller,
    String? hintText,
    // IconData? icon,
    Widget? prefixIcon,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? const SizedBox(),
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: maxLines ?? 1,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field connot be left blank";
          } else {
            return null;
          }
        },
      ),
    );
  }

  buildRadioButton({
    BuildContext? context,
    required String title,
    required String value,
    required String? groupValue,
    required void Function(String?)? onChanged,
  }) {
    final inputColor = Theme.of(context!).inputDecorationTheme.fillColor;
    return Ink(
      decoration: BoxDecoration(
        color: inputColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: RadioListTile<String>(
        title: Text(title),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }

  _addNewPetFunction() {
    final newPetDetails = PetsModel(
      name: _nameController.text,
      age: _ageController.text,
      price: _priceController.text,
      breed: _breedController.text,
      image: _imageController.text,
      location: _locationController.text,
      gender: _selectedGender ?? 'Male',
      detail: _detailsController.text,
    );
    context.read<PetsBloc>().add(
          AddNewPetEvent(
            addNewPet: newPetDetails,
            onSuccess: () {
              _nameController.clear();
              _ageController.clear();
              _priceController.clear();
              _breedController.clear();
              _nameController.clear();
              _imageController.clear();
              _locationController.clear();
              _detailsController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${_nameController.text} details has been uploaded",
                  ),
                ),
              );
            },
          ),
        );
  }
}
