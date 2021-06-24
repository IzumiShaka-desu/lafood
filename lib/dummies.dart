import 'package:lafoody/model/food.dart';

List<Food> foods = List.generate(
  10,
  (index) => Food(
      idFood: '$index',
      name:'food $index',
      ingredients: 'dfgfdgdfg  fdgdgfgdfg dfg dfg jhguyguyfguy fghfhf sdgedrg yfguytiftyf fuytifytu fy6tfy',
      price: ' $index.000'),
);
