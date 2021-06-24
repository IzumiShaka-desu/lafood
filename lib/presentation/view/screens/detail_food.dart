import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/model/food.dart';
import 'package:lafoody/presentation/viewmodel/food_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailFood extends StatelessWidget {
  final Food food;
  final FoodViewmodel foodViewmodel = Get.find(tag: 'fc');
  DetailFood({Key key, this.food}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: ColorPalette.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorPalette.primaryYellow,
          title: Text(food.name),
          actions: [
            IconButton(
              icon: Obx(() => foodViewmodel.isFavorite(food.idFood)
                  ? Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    )
                  : Icon(Icons.favorite_border)),
              onPressed: () async {
                foodViewmodel.updateFav(food.idFood);
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: ColorPalette.backgroundGradient),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 170,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    food.urlPhoto,
                  ),
                  placeholder: AssetImage('images/loading.gif'),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [Text(food.ingredients)],
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [Text(food.ingredients)],
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
                        child: Text('Rp. ' + food.price),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'chat',
                  style: Get.textTheme.subtitle1.copyWith(color: Colors.white),
                ),
              ],
            ),
            onPressed: () async {
              if (Platform.isAndroid) {
                var phone = food.phone;
                await launch(
                    'https://wa.me/+62$phone/?text=${Uri.parse('halo saya tertarik dengan makanan bernama ' + food.name + ' dari aplikasi LaFoody')}');
              }
            },
            color: ColorPalette.primaryDark,
          ),
        ),
      ),
    );
  }
}
