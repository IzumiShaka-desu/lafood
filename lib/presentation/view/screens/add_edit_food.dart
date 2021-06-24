import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/model/food.dart';
import 'package:lafoody/presentation/viewmodel/food_viewmodel.dart';
import 'package:lafoody/service/local_service.dart';

class AddEditFood extends StatefulWidget {
  @override
  _AddEditFoodState createState() => _AddEditFoodState();
}

class _AddEditFoodState extends State<AddEditFood> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ingController = TextEditingController();
  TextEditingController variantController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  File image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: ColorPalette.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorPalette.primaryYellow,
          title: Text('add post'),
          
        ),
        body: Container(
          decoration: BoxDecoration(gradient: ColorPalette.backgroundGradient),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 150,
                width: 170,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorPalette.primaryDark),
                      ),
                      child: image != null
                          ? ClipOval(
                              child: Image.file(
                                image,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: ColorPalette.primaryDark,
                                size: 35,
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () async {
                          try {
                            ImagePicker picker = ImagePicker();
                            PickedFile pickedImage = await picker.getImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              setState(() {
                                image = File(pickedImage.path);
                              });
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: ExpansionTile(
                    leading: Icon(Icons.food_bank),
                    title: Text('name'),
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintMaxLines: 2,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: ' grilled sausage',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: ExpansionTile(
                    leading: Icon(Icons.food_bank),
                    title: Text('ingredients'),
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: TextFormField(
                          controller: ingController,
                          decoration: InputDecoration(
                            hintMaxLines: 2,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: ' sausage, water',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: ExpansionTile(
                    leading: Icon(Icons.fastfood),
                    title: Text('Variant'),
                    children: [
                      Container(
                        height: 75,
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: TextFormField(
                          controller: variantController,
                          decoration: InputDecoration(
                            hintMaxLines: 2,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'variant a, variant b',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: ExpansionTile(
                    leading: Icon(Icons.label),
                    title: Text('Price'),
                    children: [
                      Container(
                        height: 30,
                        color: Colors.white,
                        child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefix: Text('Rp.'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: '20000',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () async {
              String name = nameController.text;
              String ingre = ingController.text;
              String variant = variantController.text;
              String price = priceController.text;
              if (name.isEmpty ||
                  ingre.isEmpty ||
                  variant.isEmpty ||
                  price.isEmpty ||
                  image == null) {
                Get.snackbar('warning', 'all field and image is required');
              } else {
                FoodViewmodel foodVM = Get.find(tag: 'fc');

                var idUser = (await LocalService().getLoginDetails())['idUser'];
                var food = Food(
                  name: name,
                  ingredients: ingre,
                  variant: variant,
                  price: price,
                  idUser: (idUser).toString(),
                );
                try {
                  await foodVM.insertFood(food, image);
                } catch (e) {
                  debugPrint(e.toString());
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'save',
                style: Get.textTheme.subtitle1.copyWith(color: Colors.white),
              ),
            ),
            color: ColorPalette.primaryDark,
          ),
        ),
      ),
    );
  }
}
