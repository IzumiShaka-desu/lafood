import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/model/food.dart';
import 'package:lafoody/presentation/viewmodel/food_viewmodel.dart';

class MyFood extends StatelessWidget {
  final FoodViewmodel foodViewmodel = Get.find(tag: 'fc');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorPalette.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorPalette.primaryYellow,
          title: Text('My Post'),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: foodViewmodel.myFoods.length,
              itemBuilder: (BuildContext context, int index) {
                var item = foodViewmodel.myFoods[index];
                return MyFoodContainer(item: item);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyFoodContainer extends StatelessWidget {
  const MyFoodContainer({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Food item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 90,
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    item.urlPhoto,
                  ),
                  placeholder: AssetImage('images/loading.gif'),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            item.name,
                            style: Get.textTheme.subtitle2
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  item.ingredients,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline_outlined),
                          onPressed: () async {
                            final FoodViewmodel foodViewmodel =
                                Get.find(tag: 'fc');
                            foodViewmodel.deleteFood(item.idFood);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
