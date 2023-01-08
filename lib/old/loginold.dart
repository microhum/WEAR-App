// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:wearapplication/model/profile.dart';
// import 'package:wearapplication/screen/home.dart';
// import 'package:wearapplication/screen/welcome.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _storage = const FlutterSecureStorage();
//   final TextEditingController _emailController =
//       TextEditingController(text: "");
//   final TextEditingController _passwordController =
//       TextEditingController(text: "");

//   //reading values
//   Future<void> _readFromStorage() async {
//     _emailController.text = await _storage.read(key: "KEY_EMAIL") ?? "";
//     _passwordController.text = await _storage.read(key: "KEY_PASSWORD") ?? "";
//   }

//   void initstate() {
//     super.initState();
//     _readFromStorage();
//   }

//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   final formKey = GlobalKey<FormState>();
//   Profile profile = Profile(
//     email: "",
//     password: "",
//   );
//   final Future<FirebaseApp> firebase = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: firebase,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("Error"),
//               ),
//               body: Center(
//                 child: Text("${snapshot.error}"),
//               ),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("Login"),
//               ),
//               body: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("E-mail", style: TextStyle(fontSize: 20)),
//                         TextFormField(
//                           controller: _emailController,
//                           validator: MultiValidator([
//                             RequiredValidator(errorText: "Required"),
//                             EmailValidator(
//                                 errorText: "Please add in Email form")
//                           ]),
//                           keyboardType: TextInputType.emailAddress,
//                           onSaved: (String? email) {
//                             profile.email = email!;
//                           },
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text("Password", style: TextStyle(fontSize: 20)),
//                         TextFormField(
//                           controller: _passwordController,
//                           validator:
//                               RequiredValidator(errorText: "required password"),
//                           obscureText: true,
//                           onSaved: (String? password) {
//                             profile.password = password!;
//                           },
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                               child: Text("Login"),
//                               onPressed: () async {
//                                 if (formKey.currentState!.validate()) {
//                                   formKey.currentState!.save();

//                                   try {
//                                     await FirebaseAuth.instance
//                                         .signInWithEmailAndPassword(
//                                             email: profile.email,
//                                             password: profile.password)
//                                         .then((value) {
//                                       formKey.currentState!.reset();
//                                       Fluttertoast.showToast(
//                                           msg: "Login Successfully",
//                                           gravity: ToastGravity.CENTER);

//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(builder: (context) {
//                                           return WelcomeScreen();
//                                         }),
//                                       );
//                                     });

//                                     //write key
//                                     await _storage.write(
//                                         key: "KEY_EMAIL", value: profile.email);
//                                     await _storage.write(
//                                         key: "KEY_PASSWORD",
//                                         value: profile.password);
//                                   } on FirebaseAuthException catch (e) {
//                                     Fluttertoast.showToast(
//                                         msg: e.message!,
//                                         gravity: ToastGravity.CENTER);
//                                   }
//                                 }
//                               }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//   }
// }
