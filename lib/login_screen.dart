// import 'package:flutter/material.dart';
// import 'authentication_service.dart';
// import 'package:go_router/go_router.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _errorMessage = '';
//   bool _isPasswordVisible = false;


//   void _login() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final username = _usernameController.text;
//       final password = _passwordController.text;
//       if (AuthenticationService.login(username, password)) {
//         context.go('/home');
//       } else {
//         setState(() {
//           _errorMessage = 'Invalid credentials';
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/background.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(50.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/logo.png', width: 250, height: 250), 
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: const InputDecoration(labelText: 'Username',
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Color(0xFF266D80), width: 1.0),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Color(0xFF266D80), width: 1.0),
//                                       ),
//                                     ),
                    
//                     validator: (value) =>
//                         value?.isEmpty?? true? 'Enter your username' : null,
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF266D80), width: 1.0),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF266D80), width: 1.0),
//                       ),
//                       suffixIcon: GestureDetector(
//                         onTap: () {
                          
//                           setState(() {
//                             _isPasswordVisible =!_isPasswordVisible;
//                           });
//                         },
//                         child: Icon(
//                           _isPasswordVisible? Icons.visibility_off : Icons.visibility,
//                           color: Colors.grey, 
//                         ),
//                       ),
//                     ),
//                     obscureText:!_isPasswordVisible, 
//                     validator: (value) =>
//                         value?.isEmpty?? true? 'Enter your password' : null,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.resolveWith<Color>(
//                       (Set<WidgetState> states) {
//                         if (states.contains(WidgetState.pressed)) {
//                           return const Color(0xFF266D80); 
//                         }
//                         return const Color(0xFF73CCE4); 
//                       },
//                     ),
//                     foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
//                   ),
//                     onPressed: _login, 
//                     child: const Text('Login')),
//                   if (_errorMessage.isNotEmpty)
//                     Text(_errorMessage, style: const TextStyle(color: Colors.red)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
