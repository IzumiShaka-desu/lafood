import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart' as httpParser;
import 'package:lafoody/model/favorite.dart';
import 'package:lafoody/model/food.dart';
import 'package:lafoody/model/profile.dart';
import 'package:lafoody/service/local_service.dart';

abstract class NetService {
  Future<List<Food>> getFoods();
  Future<Profile> getProfile();
  Future<Profile> login(String email, String password);
  Future<Map> register(Profile profile);
  Future<bool> addOrUpdateRecipe(Food food, {File newImage});
  Future<bool> deleteFood(String id);
  Future<bool> updateFav(String idFood);
  Future<List<Favorite>> getFavorite();
}

class NetworkService extends NetService {
  static const String BASEURL = "http://192.168.43.150";
  static const String FOODPATH = "/food";
  static const String LOGINPATH = "/auth/login";
  static const String REGISTERPATH = "/auth/register";
  static const String FAVORITEPATH = "/fav";
  static const int TIMEOUT = 10000;
  final dio = Dio(
    BaseOptions(
      baseUrl: BASEURL,
      connectTimeout: TIMEOUT,
      receiveTimeout: TIMEOUT,
    ),
  );

  @override
  Future<bool> deleteFood(String id) async {
    try {
      String path = "$FOODPATH/$id/delete";
      var response = await dio.delete(path);
      return (!response?.data['error']) ?? false;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  @override
  Future<List<Food>> getFoods() async {
    String path = FOODPATH;
    List<Food> data = [];
    var response = await dio.get(path);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return compute(foodFromJson, jsonEncode(response.data));
      }
    }
    return data;
  }

  @override
  Future<Profile> getProfile() async {
    Profile result = Profile();
    var idUser = (await (LocalService()).getLoginDetails())['idUser'];
    String path = "/user/$idUser/profile";
    try {
      var response = await dio.get(path);
      if (response.statusCode == 200) {
        var json = response.data;
        result = Profile.fromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  @override
  Future<Profile> login(String email, String password) async {
    var data = {"email": email, "password": password};
    var result = Profile();
    String path = LOGINPATH;
    var response = await dio.post(path, data: FormData.fromMap(data));
    if (response.statusCode == 200) {
      Map json = response.data['data'];
      if (json != null) {
        return Profile.fromJson(json['data']);
      }
    }

    return result;
  }

  @override
  Future<Map> register(Profile profile) async {
    var result = {"result": false, "message": "register gagal"};
    var data = profile.toJson();
    data.removeWhere((key, value) => value == null);
    String path = REGISTERPATH;
    var response = await dio.post(path, data: FormData.fromMap(data));
    if (response.statusCode == 200) {
      Map json = response.data;
      result = json['data'];
    }
    return result;
  }

  @override
  Future<bool> addOrUpdateRecipe(Food food, {File newImage}) async {
    String endpoint = FOODPATH;

    endpoint += food.idFood != null ? '/${food.idFood}/update' : '/create';
    try {
      Map<String, dynamic> recipeData = food.toJson();

      recipeData.removeWhere((key, value) => value == null);

      FormData data = FormData.fromMap(recipeData);
      if (newImage != null) {
        data.files.add(
          MapEntry(
            'image',
            (await MultipartFile.fromFile(
              newImage.path,
              contentType: httpParser.MediaType('images', 'jpg'),
            )),
          ),
        );
      }

      var response = await dio.post(
        endpoint,
        data: data,
      );
      return (!response?.data['error']) ?? false;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  @override
  Future<List<Favorite>> getFavorite() async {
    var idUser = (await (LocalService()).getLoginDetails())['idUser'];
    var endpoint = '$FAVORITEPATH/favorite/$idUser';
    List<Favorite> data = [];
    try {
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        if (response.data != null) {
          data.addAll(favoriteFromJson(jsonEncode(response.data)));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  @override
  Future<bool> updateFav(String idFood) async {
    var idUser = (await (LocalService()).getLoginDetails())['idUser'];
    var endpoint = '$FAVORITEPATH/updatefav/$idUser';
    FormData data = FormData.fromMap({'idFood': idFood});
    try {
      var response = await dio.post(
        endpoint,
        data: data,
      );
      return response.data['result'];
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
