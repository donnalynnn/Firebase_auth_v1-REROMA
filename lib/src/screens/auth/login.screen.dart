import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '/src/controllers/auth_controller.dart';
import '/src/dialogs/waiting_dialog.dart';
import '/src/routing/router.dart';
import '/src/screens/auth/registration.screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/auth";
  static const String name = "Login Screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username, password;
  late FocusNode usernameFn, passwordFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController(text: "firebase@gmail.com");
    password = TextEditingController(text: "123456Abc!");
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
  }

  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                  child: const Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 115, 22),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    
                ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Flexible(
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    child: GestureDetector(
                      onTap: () {
                        GlobalRouter.I.router.go(RegistrationScreen.route);
                      },
                      child: Text(
                        "No account? Register",
                        style: TextStyle(
                          color: _isHovering? const Color.fromARGB(255, 255, 115, 22) : Colors.black
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
                
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      const Text(
                        "Firebase Auth", // Title
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 115, 22), // Deep orange color
                        ),
                      ),
                      const SizedBox(height: 30),
                      Flexible(
                        child: TextFormField(
                          decoration: decoration.copyWith(
                              labelText: "Username",
                              prefixIcon: const Icon(Icons.person)),
                          focusNode: usernameFn,
                          controller: username,
                          onEditingComplete: () {
                            passwordFn.requestFocus();
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please fill out the username'),
                            MaxLengthValidator(32,
                                errorText:
                                    "Username cannot exceed 32 characters"),
                            EmailValidator(
                                errorText: "Please select a valid email"),
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
                            passwordFn.unfocus();

                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Password is required"),
                            MaxLengthValidator(128,
                                errorText:
                                    "Password cannot exceed 72 characters"),
                          ]).call,
                        ),
                      ),
                    ],
                  ),
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
              .login(username.text.trim(), password.text.trim()));
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
