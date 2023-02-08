import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:todolist_app_flutter/features/authentication/cubit/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/registerscreen';

  static route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const RegisterScreen());
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isHidePassword = true;
  bool isHideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      )),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.message,
              textAlign: TextAlign.center,
            )));
            Navigator.of(context).pushReplacementNamed("/loginscreen");
          } else if (state is AuthenticationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.message,
              textAlign: TextAlign.center,
            )));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 0.0, height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Username',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: colorButton)),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "The username field is required";
                        } else if (!value
                            .substring(0, value.length)
                            .contains("@")) {
                          return "Email is invalid";
                        }
                        return null;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isHidePassword,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: (() {
                              setState(() {
                                isHidePassword = !isHidePassword;
                              });
                            }),
                            icon: Icon(Icons.remove_red_eye)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: colorButton)),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "The password field is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 character";
                        }
                        return null;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Confirm Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: isHideConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: (() {
                              setState(() {
                                isHideConfirmPassword = !isHideConfirmPassword;
                              });
                            }),
                            icon: Icon(Icons.remove_red_eye)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: colorButton)),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "The password field is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 character";
                        } else if (value != _passwordController.text) {
                          return "Password does not same";
                        }
                        return null;
                      }),
                    ),
                  ),
                  const SizedBox(width: 0.0, height: 30),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthenticationCubit>()
                            .registerEmailPassword(
                                context,
                                _emailController.text,
                                _passwordController.text);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorButton, width: 2),
                          borderRadius: BorderRadius.circular(4),
                          color: colorButton),
                      child: Center(
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 0.0, height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'or',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 0.0, height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorButton, width: 2),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: Svg(
                            'icons/google.svg',
                          )),
                          const SizedBox(width: 10, height: 0.0),
                          Text(
                            'Register with Google',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 0.0, height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Already have an account?  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 12),
                              children: [
                            TextSpan(
                                text: 'Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (() {
                                    Navigator.of(context)
                                        .pushReplacementNamed("/loginscreen");
                                  }),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold))
                          ])),
                    ),
                  ),
                  const SizedBox(width: 0.0, height: 20),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
