import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/presentation/components/food_container.dart';
import 'package:lafoody/presentation/view/screens/detail_food.dart';
import 'package:lafoody/presentation/viewmodel/food_viewmodel.dart';

class MyFav extends StatelessWidget {
   final FoodViewmodel foodViewmodel = Get.find(tag: 'fc');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryYellow,
        title: Text(
          'My Favorite',
          style: Get.textTheme.headline6.copyWith(
              color: ColorPalette.primaryDark, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
        decoration: BoxDecoration(
          gradient: ColorPalette.backgroundGradient,
        ),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: foodViewmodel.myFav.length,
            itemBuilder: (BuildContext context, int index) {
              var idFood=foodViewmodel.myFav[index].idFood;
              var item = foodViewmodel.foods.firstWhere((element) => element.idFood==idFood);
              return InkWell(
                  onTap: () => Get.to(DetailFood(food: item)),
                  child: FoodContainer(item: item));
            },
          ),
        ),
      ),
    );
  }
}
