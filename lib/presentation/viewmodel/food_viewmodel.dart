import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/model/favorite.dart';
import 'package:lafoody/model/food.dart';
import 'package:lafoody/service/local_service.dart';
import 'package:lafoody/service/network_service.dart';

class FoodViewmodel extends GetxController {
  var foods = <Food>[].obs;
  var myFoods = <Food>[].obs;
  var myFav = <Favorite>[].obs;
  var isLoading = false.obs;
  var filter = ''.obs;
  NetworkService nService = NetworkService();
  LocalService lService = LocalService();
  loadFoods() async {
    isLoading.value = true;
    var _foods = await nService.getFoods();
    var idUser = (await lService.getLoginDetails())['idUser'];
    var mFoods = foods.where((element) => element.idUser == '$idUser').toList();
    foods.assignAll(_foods);
    myFoods.assignAll(mFoods);
    isLoading.value = false;
  }

  getFilteredFood() {
    if (filter.isNullOrBlank) {
      return foods;
    } else {
      return foods.where((e) => e.name.contains(filter.value)).toList();
    }
  }

  bool isFavorite(String idFood) {
    return myFav.any((element) => element.idFood == idFood);
  }

  loadFavorite() async {
    var favs = await nService.getFavorite();
    myFav.assignAll(favs);
  }

  loadAllData() {
    loadFoods();
    loadFavorite();
  }

  insertFood(Food food, File images) async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);

    var result = await nService.addOrUpdateRecipe(food, newImage: images);

    loadFoods();
    if (result) {
      Get.back();
      loadFoods();
      Get.snackbar(
        'notification',
        'sucessfull add post',
      );
      Timer(Duration(milliseconds: 3005), () {
        Get.back();
      });
    } else {
      Get.back();
      Get.snackbar('notification', 'cannot add post');
    }
  }

  deleteFood(String idFood) async {
    var result = await nService.deleteFood(idFood);
    loadFoods();
    if (result) {
      Get.snackbar(
        'notification',
        'sucessfull delete post',
      );
      loadFoods();
    } else {
      Get.snackbar('notification', 'cannot sucessfull delete post');
    }
  }

  updateFav(String idFood) async {
    var result = await nService.updateFav(idFood);
    if (result) {
      Get.showSnackbar(
        GetBar(
          message: 'sucessfull update favorite data',
          duration: Duration(seconds: 1),
        ),
      );
      loadAllData();
    } else {
      Get.showSnackbar(
        GetBar(
          message: 'cannot update favorite data',
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
