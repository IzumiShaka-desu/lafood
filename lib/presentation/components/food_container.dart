import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/model/food.dart';

class FoodContainer extends StatelessWidget {
  const FoodContainer({
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
                  image: NetworkImage(item.urlPhoto,),
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        item.ingredients,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
