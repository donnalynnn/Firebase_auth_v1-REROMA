import 'package:firebase_auth_v1/src/screens/auth/login.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../routing/router.dart';
import '/src/controllers/auth_controller.dart';
import '/src/dialogs/waiting_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = "/register";
  static const String name = "Registration Screen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username, password, password2;
  late FocusNode usernameFn, passwordFn, password2Fn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController();
    usernameFn = FocusNode();
    password = TextEditingController();
    passwordFn = FocusNode();
    password2 = TextEditingController();
    password2Fn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    usernameFn.dispose();
    password.dispose();
    passwordFn.dispose();
    password2.dispose();
    password2Fn.dispose();
  }

  bool _isHovering = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 216, 216),
      
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          height: 52,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    onSubmit();
                  },
                  // ignore: sort_child_properties_last
                  child: const Text("Register"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 115, 22),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18),
                      minimumSize: const Size(double.infinity, 60),
                ),
                ),
              ),

              // const SizedBox(height: 20),

              Center(
                child: Flexible(
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    child: GestureDetector(
                      onTap: () {
                        GlobalRouter.I.router.go(LoginScreen.route);
                      },
                      child: Text(
                        "Already have an account? Login here",
                        style: TextStyle(
                          color: _isHovering? const Color.fromARGB(255, 255, 115, 22): Colors.black
                        ),
                      ),
                    ),
                    ),
                
                  ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                        "Registration", // Title
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 115, 22), // Deep orange color
                        ),
                      ),
                const SizedBox(height: 30),
                Flexible(
                  child: TextFormField(
                    decoration: decoration.copyWith(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.person)),
                    focusNode: usernameFn,
                    controller: username,
                    onEditingComplete: () {
                      passwordFn.requestFocus();
                    },
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Please fill out the username'),
                      EmailValidator(errorText: "Please select a valid email"),
                    ]).call,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obfuscate,
                    decoration: decoration.copyWith(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obfuscate = !obfuscate;
                              });
                            },
                            icon: Icon(obfuscate
                                ? Icons.remove_red_eye_rounded
                                : CupertinoIcons.eye_slash))),
                    focusNode: passwordFn,
                    controller: password,
                    onEditingComplete: () {
                      password2Fn.requestFocus();

                      ///call submit maybe?
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password is required"),
                      MinLengthValidator(12,
                          errorText:
                              "Password must be at least 12 characters long"),
                      MaxLengthValidator(128,
                          errorText: "Password cannot exceed 72 characters"),
                      PatternValidator(
                          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                          errorText:
                              'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.')
                    ]).call,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obfuscate,
                      decoration: decoration.copyWith(
                          labelText: "Confirm Password",
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obfuscate = !obfuscate;
                                });
                              },
                              icon: Icon(obfuscate
                                  ? Icons.remove_red_eye_rounded
                                  : CupertinoIcons.eye_slash))),
                      focusNode: password2Fn,
                      controller: password2,
                      onEditingComplete: () {
                        password2Fn.unfocus();

                        ///call submit maybe?
                      },
                      validator: (v) {
                        String? doesMatchPasswords =
                            password.text == password2.text
                                ? null
                                : "Passwords doesn't match";
                        if (doesMatchPasswords != null) {
                          return doesMatchPasswords;
                        } else {
                          return MultiValidator([
                            RequiredValidator(
                                errorText: "Password is required"),
                            MinLengthValidator(12,
                                errorText:
                                    "Password must be at least 12 characters long"),
                            MaxLengthValidator(128,
                                errorText:
                                    "Password cannot exceed 72 characters"),
                            PatternValidator(
                                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                                errorText:
                                    'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.'),
                          ]).call(v);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(context,
          future: AuthController.I
              .register(username.text.trim(), password.text.trim()));
    }
  }

  final OutlineInputBorder _baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  InputDecoration get decoration => InputDecoration(
      // prefixIconColor: AppColors.primary.shade700,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: 3,
      disabledBorder: _baseBorder,
      enabledBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Colors.black87, width: 1),
      ),
      focusedBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Color.fromARGB(255, 255, 193, 68), width: 1),
      ),
      errorBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Color.fromARGB(255, 255, 64, 64), width: 1),
      )
      
      );
}
