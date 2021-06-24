import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:get/get.dart';
import 'package:lafoody/presentation/view/screens/register.dart';
import 'package:lafoody/presentation/viewmodel/auth_viewmodel.dart';

class Login extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LaFoody',
                        style: Get.textTheme.headline4
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(' Hi Glad  to see you again',
                              style: Get.textTheme.bodyText1),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: emailController,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'email is required';
                                    } else if (!val.isEmail) {
                                      return 'please input a valid email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    labelText: 'Email',
                                    hintText: 'youremail@mail.com',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passController,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'password is required';
                                    } else if (val.length < 6) {
                                      return 'minimum 6 characters ';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock_outline),
                                    labelText: 'Password',
                                    hintText: 'yourpassword20',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: Get.textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    AuthViewmodel authViewmodel =
                                        Get.find(tag: 'ac');
                                    authViewmodel.login(
                                        emailController.text.trim(),
                                        passController.text.trim());
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Next',
                                    style: Get.textTheme.bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                color: ColorPalette.primaryDark,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account?',
                              children: [
                                TextSpan(
                                  text: ' Sign Up',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(Register()),
                                  style: Get.textTheme.bodyText1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
