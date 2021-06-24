import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/presentation/components/food_container.dart';
import 'package:lafoody/presentation/view/screens/add_edit_food.dart';
import 'package:lafoody/presentation/view/screens/detail_food.dart';
import 'package:lafoody/presentation/view/screens/my_fav.dart';
import 'package:lafoody/presentation/viewmodel/food_viewmodel.dart';
import 'my_food.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FoodViewmodel foodViewmodel = Get.find(tag: 'fc');
  @override
  void initState() {
    foodViewmodel.loadAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryYellow,
        title: Text(
          'LaFoody',
          style: Get.textTheme.headline6.copyWith(
              color: ColorPalette.primaryDark, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh_outlined,
              color: ColorPalette.primaryDark,
            ),
            onPressed: () {
              foodViewmodel.loadAllData();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border_outlined,
              color: ColorPalette.primaryDark,
            ),
            onPressed: () => Get.to(MyFav()),
          ),
          IconButton(
            icon: Icon(
              Icons.folder_open,
              color: ColorPalette.primaryDark,
            ),
            onPressed: () => Get.to(MyFood()),
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: ColorPalette.primaryDark,
            ),
            onPressed: () {
              Get.to(AddEditFood());
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 15),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => TextFormField(
                      onChanged: (val) {
                        foodViewmodel.filter.value = val;
                      },
                      initialValue: foodViewmodel.filter.value,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Icon(Icons.search_rounded),
                        ),
                        hintText: 'Find food, drink, and snack',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Obx(
                  () => foodViewmodel.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodViewmodel.getFilteredFood().length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = foodViewmodel.getFilteredFood()[index];
                            return InkWell(
                                onTap: () => Get.to(DetailFood(food: item)),
                                child: FoodContainer(item: item));
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
