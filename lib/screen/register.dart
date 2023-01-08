import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:wearapplication/screen/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const Color primaryColor = Color(0xFF13B5A2);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  bool passwordHidden = true;

  // Read values

  _onFormSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _usernameController.text,
                password: _passwordController.text)
            .then((value) {
          _formKey.currentState!.reset();
          Fluttertoast.showToast(
              msg: "Created Successfully", gravity: ToastGravity.CENTER);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } on FirebaseAuthException catch (e) {
        print(e.code);
        Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.CENTER);
      }
    }
  }

  _onSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }),
    );
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
              body: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(size.width - size.width * .85),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * .10,
                      ),
                      const Text(
                        "Welcome back.",
                        style: TextStyle(
                            color: Color(0xFF161925),
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                      SizedBox(
                        height: size.height * .15,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle:
                                    const TextStyle(color: primaryColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(
                                      color: primaryColor, width: 2),
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                                EmailValidator(
                                    errorText: "Please add in Email form")
                              ]),
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              validator: RequiredValidator(
                                  errorText: "required password"),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                    const TextStyle(color: Color(0xFF95989A)),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(
                                      color: primaryColor, width: 2),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passwordHidden = !passwordHidden;
                                    });
                                  },
                                  child: Icon(
                                    passwordHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xff747881),
                                    size: 23,
                                  ),
                                ),
                              ),
                              controller: _passwordController,
                              obscureText: passwordHidden,
                              enableSuggestions: false,
                              toolbarOptions: const ToolbarOptions(
                                copy: false,
                                paste: false,
                                cut: false,
                                selectAll: false,
                                //by default all are disabled 'false'
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: _onFormSubmit,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              textStyle: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          child: const Text("Sign Up"),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .015,
                      ),
                      SizedBox(
                        height: size.height * .035,
                      ),
                      const Center(
                        child: Text(
                          "Already have account?",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Center(
                        child: InkWell(
                          onTap: _onSignIn,
                          child: const Text(
                            "Back to Sign In?",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
