import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_bloc.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_event.dart';
import 'package:myflutter/modules/auth/reset_password/reset_passwordbloc/password_state.dart';
import 'package:myflutter/widgets/custom_button.dart';
import 'package:myflutter/widgets/custom_form_field.dart';

import '../../../utils/enum.dart';

class ForgetPasswordView extends StatelessWidget {
   ForgetPasswordView({super.key});
   final TextEditingController emailController = TextEditingController();
   final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(onPressed: (){context.pop();}, icon:Icon(Icons.arrow_back)),
        title: Text("Reset Password"),
        centerTitle: true
      ),
      body: BlocConsumer<ResetPasswordBloc, ResetPasswordStates>(
    listener: (context, state) {
      if (state.postApiStatus == PostApiStatus.COMPLETED) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
        context.pop();
      }

      if (state.postApiStatus == PostApiStatus.ERROR) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Image.asset(
                "assets/images/myflutterlogo.png",
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              CustomFormField(
                prefixIcon: const Icon(Icons.email_outlined),
                hint: "Enter your email",
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              CustomButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    context.read<ResetPasswordBloc>().add(
                      PasswordchangeEvent(
                        password: emailController.text,
                      ),
                    );

                    context.read<ResetPasswordBloc>().add(
                      const ForgetpasswordApi(),
                    );
                  }
                },
                title: "Reset Password",
                loading: state.postApiStatus == PostApiStatus.LOADING,
              ),
            ],
          ),
        ),
      );
    },
    ),
    );
  }
}
