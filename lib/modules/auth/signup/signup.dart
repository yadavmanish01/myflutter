import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/routes/app_route_constant.dart';

import '../../../extens/constants.dart';
import '../../../utils/customToast.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_form_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

final _formkey = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;
class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width*0.2,),
                Image.asset("assets/images/myflutterlogo.png",height: MediaQuery.of(context).size.height*0.1,),
                SizedBox(height: MediaQuery.of(context).size.width*0.1,),
                CustomFormField(
                  hint: "Enter your email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email cannot be empty";
                    }
                    return null;
                  },
                ),
                15.ph,
                CustomFormField(
                  hint: "Enter your password",
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                ),
                55.ph,
                CustomButton(loading: false,
                  title: "Signup",
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _auth.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ).then((value){}).onError((error,StackTrace){
                       Utils().Customtoast(error.toString());
                      });
                    }
                  },
                ),
                35.ph,
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    children: <TextSpan>[
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                        // Adding a tap action to this specific span
                        recognizer: TapGestureRecognizer()..onTap = () {context.pushNamed(MyAppRouteConstants.loginRouteName);},
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
