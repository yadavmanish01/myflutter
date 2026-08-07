import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/login/google_Signin_bloc/google_signin_bloc.dart';
import 'package:myflutter/modules/auth/login/loginbloc/login_state.dart';
import 'package:myflutter/routes/app_route_config.dart';
import 'package:myflutter/routes/app_route_constant.dart';
import 'package:myflutter/utils/appstyles.dart';
import 'package:myflutter/widgets/custom_button.dart';
import 'package:myflutter/widgets/custom_form_field.dart';
import '../../../extens/constants.dart';
import '../../../utils/customToast.dart';
import '../../../utils/enum.dart';
import 'loginbloc/login_bloc.dart';
import 'loginbloc/login_event.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

final _formkey = GlobalKey<FormState>();

class _LoginviewState extends State<Loginview> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleSigninBloc, GoogleSigninState>(
  listener: (context, googleState) {
    if (googleState.loginStatus == PostApiStatus.COMPLETED) {
      Utils().Customtoast(googleState.message);

      context.goNamed(MyAppRouteConstants.homeRouteName);
    }
    if (googleState.loginStatus == PostApiStatus.ERROR) {
      Utils().Customtoast(googleState.message);
    }
  },
  child: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.COMPLETED) {
          Utils().Customtoast(state.message);
          context.goNamed(MyAppRouteConstants.homeRouteName);
        }

        if (state.postApiStatus == PostApiStatus.ERROR) {
          Utils().Customtoast(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.2),
                    Image.asset(
                      "assets/images/myflutterlogo.png",
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
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
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility),
                      ),
                    ),
                    5.ph,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {context.pushNamed(
                          MyAppRouteConstants.resetPasswordName,
                        );},
                        child: Text(
                          "Forget password?",
                          style: AppStyle.body.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    55.ph,
                    CustomButton(
                      loading: state.postApiStatus == PostApiStatus.LOADING,
                      title: "Login",
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                            EmailChanged(emailController.text),
                          );

                          context.read<LoginBloc>().add(
                            PasswordChanged(passwordController.text),
                          );

                          context.read<LoginBloc>().add(const LoginApi());
                        }
                      },
                    ),
                    20.ph,
                    BlocBuilder<GoogleSigninBloc, GoogleSigninState>(
                      builder: (context, state) {
                        if (state.loginStatus == PostApiStatus.LOADING) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            context.read<GoogleSigninBloc>().add(
                              const GoogleSignInApi(),
                            );
                          },
                          icon: Image.network(
                            "https://developers.google.com/identity/images/g-logo.png",
                            width: 24,
                          ),
                          label: const Text(
                            "Continue with Google",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                    35.ph,
                    Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(text: 'Don\'t have an account? '),
                          TextSpan(
                            text: 'Sign Up.',
                            style: const TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                            // Adding a tap action to this specific span
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.goNamed(
                                  MyAppRouteConstants.signupRouteName,
                                );
                              },
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
      },
    ),
);
  }
}
