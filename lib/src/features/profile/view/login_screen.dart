import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/app_routes.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF000000), // глубокий черный
                    Color(0xFF0D0D0D), // почти черный с легкой подсветкой
                    Color(0xFF1A1A1A), // мягкий темно-серый
                    Color(0xFF262626), // ещё светлее, для плавного перехода
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.4, 0.7, 1.0], // растягиваем переходы
                ),
              ),
            ),
            SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                      left: 18,
                      right: 18,
                      bottom: MediaQuery.of(context).size.height / 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Добро пожаловать",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        autocorrect: false,
                        controller: emailController,
                        key: const Key('emailTextField'),
                        decoration: InputDecoration(
                          hintText: "Почта",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Введите почту";
                          }

                          if (!Regex.email.hasMatch(value)) {
                            return "Некорректная почта";
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
                          hintText: "Пароль",
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
                            return "Введите пароль";
                          }
                          if (value.length < 6) {
                            return "Пароль слишком короткий";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: Colors.white,
                                  overlayColor: Colors.grey),
                              key: const Key('logInButton'),
                              child: Text(
                                style: TextStyle(color: Colors.black),
                                "Войти",
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthBloc>().add(AuthEvent.login(
                                        username: emailController.text,
                                        password: passwordController.text,
                                      ));
                                }
                              },
                            ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: const BorderSide(color: Colors.white),
                            elevation: 2,
                          ),
                          label: const Text(
                            'Регистрация',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            context.pushNamed(AppRoute.register.name);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: const BorderSide(color: Colors.white),
                            elevation: 2,
                          ),
                          icon: Image.asset(
                            "assets/icons/google.png",
                            height: 20,
                            width: 20,
                          ),
                          label: const Text(
                            ' Войти через Google',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEvent.loginWithGoogle());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      listener: (context, state) {
        state.maybeWhen(
          login: (loginModel) {
            context.pop();
          },
          error: () {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Произошла ошибка",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
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
          orElse: () {},
        );
      },
    );
  }
}

class Regex {
  static final email = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
}
