import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/model/profile.dart';
import 'package:lafoody/presentation/view/screens/page_container.dart';
import 'package:lafoody/presentation/viewmodel/auth_viewmodel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  DateTime dob = DateTime.now();
  TextEditingController fname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: ColorPalette.backgroundGradient),
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' Hi Please complete your personal data',
                style: Get.textTheme.subtitle1),
            Expanded(
              child: Column(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Container(
                      child: Form(
                        key: _formkey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        child: TextFormField(
                                          controller: fname,
                                          maxLines: 1,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'fullname is required';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.person_outline),
                                            labelText: 'Fullname',
                                            hintText: 'your name',
                                            fillColor: ColorPalette.lightYellow,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  style: BorderStyle.none,
                                                  width: 0.002),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                          child: InputDatePickerFormField(
                                        initialDate: DateTime(2001),
                                        onDateSaved: (value) => setState(() {
                                          dob = value;
                                        }),
                                        onDateSubmitted: (value) =>
                                            setState(() {
                                          dob = value;
                                        }),
                                        fieldLabelText: 'Birth Date',
                                        firstDate: DateTime(1800),
                                        lastDate: DateTime.now(),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        child: TextFormField(
                                          maxLines: 1,
                                          controller: email,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'email is required';
                                            } else if (!val.isEmail) {
                                              return 'please input a valid email';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.email_outlined),
                                            labelText: 'Email',
                                            hintText: 'youremail@mail.com',
                                            fillColor: ColorPalette.lightYellow,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  style: BorderStyle.none,
                                                  width: 0.002),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Container(
                                        child: TextFormField(
                                          controller: phone,
                                          maxLines: 1,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'phone is required';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            prefix: Text('+62'),
                                            prefixIcon:
                                                Icon(Icons.phone_android),
                                            labelText: 'Phone',
                                            hintText: '89565XXXXX',
                                            fillColor: ColorPalette.lightYellow,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  style: BorderStyle.none,
                                                  width: 0.002),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                        child: TextFormField(
                                          controller: pass,
                                          obscureText: true,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'password is required';
                                            } else if (val.length < 6) {
                                              return 'minimum 6 characters ';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.lock_outline),
                                            labelText: 'Password',
                                            hintText: 'yourpassword20',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () {
                                          if (_formkey.currentState
                                              .validate()) {
                                            var user = Profile(
                                                dob:
                                                    '${dob.year}-${dob.month}-${dob.day}',
                                                email: email.text.trim(),
                                                password: pass.text.trim(),
                                                nama: fname.text.trim(),
                                                phone: phone.text.trim());
                                            print(user.toJson().toString());
                                            AuthViewmodel authViewmodel =
                                                Get.find(tag: 'ac');
                                            authViewmodel.register(user);
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
                                      text: 'Already have an account?',
                                      children: [
                                        TextSpan(
                                          text: ' Sign In',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                () => Get.to(PageContainer()),
                                          style:
                                              Get.textTheme.bodyText1.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
