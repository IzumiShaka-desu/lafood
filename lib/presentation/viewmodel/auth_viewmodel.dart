import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/model/profile.dart';
import 'package:lafoody/presentation/view/screens/page_container.dart';
import 'package:lafoody/service/local_service.dart';
import 'package:lafoody/service/network_service.dart';

class AuthViewmodel extends GetxController {
  RxBool _isLogin = false.obs;
  RxBool _isLoginSuccess = false.obs;
  RxBool _isRegisterLoading = false.obs;
  RxString _email = RxString();
  RxInt _idUser = RxInt();
  Rx<Profile> _profile = Rx<Profile>();
  final LocalService _sPrefService = LocalService();
  final NetworkService _networkService = NetworkService();
  Rx<Profile> get profile => _profile;
  RxBool get loginStatus => _isLogin;
  RxBool get isLoginSuccess => _isLoginSuccess;
  RxBool get isRegisterLoading => _isRegisterLoading;
  get email => _email;
  get uid => _idUser;
  @override
  void onInit() {
    loadAuthentication();
    super.onInit();
  }

  loadAuthentication() async {
    bool _loginStat = await _sPrefService.getLoginStatus();
    _isLogin.value = _loginStat;
    if (_loginStat) {
      Map _data = await _sPrefService.getLoginDetails();
      print(
        _data['idUser'],
      );
      try {
        _email.value = _data['email'].toString();
        _idUser.value = _data['idUser'];

        _profile.value = await _networkService.getProfile();
      } catch (e) {
        printError(
          info: e.toString(),
        );
      }
    } else {
      _email.value = 'none';
      _idUser.value = -1;
      _profile.value = Profile();
    }
  }

  Future login(String email, String password) async {
     Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    Profile result;
    try {
      result = await _networkService.login(email, password);
      debugPrint(result.toJson().toString());
    } catch (e) {
      printError(
        info: e.toString(),
      );
    }
    if (result?.idUser!=null) {
      _isLoginSuccess.value = true;
      _sPrefService.saveLoginDetails(
        email,
        int.tryParse(
          result.idUser,
        ),
      );
    }
    Timer(
      Duration(seconds: 1),
      () {
        loadAuthentication();
        _isLoginSuccess.value = false;
      },
    );
    Get.back();
    Get.showSnackbar(
      GetBar(
        duration: Duration(seconds: 2),
        message:
            result?.idUser!=null ?? false ? "Login success" : "Login not success",
      ),
    );
    
  }

  Future register(Profile newProfile) async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    var result;
    try {
      result = await _networkService.register(newProfile);
      if (result != null) {
        if (result['result'] ?? false) {
          Timer(
            Duration(milliseconds: 1),
            () {
              Get.offAll(
                PageContainer(),
              );
            },
          );
        }
        
      }
    } catch (e) {
      printError(
        info: e.toString(),
      );
    }
Get.back();
        Get.snackbar('status', result['message']??'');
    _isRegisterLoading.value = false;
  }

  logOut() async {
    _sPrefService.removeLoginDetails().then(
          (value) => loadAuthentication(),
        );
  }
}
