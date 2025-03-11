import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/profile/models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "localization.welcomeMessageText",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: Theme.of(context).textTheme.labelMedium,
                      autocorrect: false,
                      controller: emailController,
                      key: const Key('emailTextField'),
                      decoration: InputDecoration(
                        hintText: "localization.hintEmailText",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "localization.emailRequiredText";
                        }

                        if (!Regex.email.hasMatch(value)) {
                          return "localization.emailInvalidText";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: Theme.of(context).textTheme.labelMedium,
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      key: const Key('passwordTextField'),
                      decoration: InputDecoration(
                        hintText: "localization.hintPasswordText",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "localization.passwordRequiredText";
                        }
                        if (value.length < 6) {
                          return "localization.passwordTooShortText";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            key: const Key('logInButton'),
                            child: Text(
                              "localization.loginButtonText",
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(AuthEvent.login(
                                      username: emailController.text,
                                      password: passwordController.text,
                                    ));
                              }
                            },
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      key: const Key("registerNow"),
                      onPressed: () {
                        context.pushNamed(AppRoute.register.name);
                      },
                      child: Text(
                        "localization.notRegisteredText",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Platform.isIOS
                        ? TextButton(
                            key: const Key("loginWithApple"),
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthEvent.loginWithApple());
                            },
                            child: const Text(
                              "sign in with Apple",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    TextButton(
                      key: const Key("loginWithGoogle"),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEvent.loginWithGoogle());
                      },
                      child: const Text(
                        "sign in with Google",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      listener: (context, state) {
        state.when(
          login: (LoginModel login) async {
            context.goNamed(AppRoute.search.name);
          },
          loggedOut: () {
            context.goNamed(AppRoute.login.name);
          },
          error: () {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                 " localization.loginErrorText",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          registrationError: (_) {
            setState(() {
              isLoading = false;
            });
          },
          loading: () {
            setState(() {
              isLoading = true;
            });
          },
          initial: () {},
        );
      },
    );
  }
}

class Regex {
  static final email = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
}
