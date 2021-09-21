import 'package:flutter/material.dart';
import 'package:hts/screens/auth/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getPercentage(5, constraints.maxWidth)),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Text(
                            "Sell A Room",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Container(
                        //   child: Text(
                        //     "Explore and book hostel around you",
                        //     style: TextStyle(fontSize: 17, color: Colors.blue),
                        //   ),
                        // ),
                        SizedBox(
                          height: getPercentage(10, constraints.maxHeight),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Email"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Password"),
                          ),
                        ),
                        SizedBox(
                          height: getPercentage(5, constraints.maxHeight),
                        ),
                        MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () => null,
                            color: Colors.blueAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )),
                        SizedBox(
                          height: 65,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have an account?"),
                              TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginScreen())),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // void submitForm(AuthService authService) {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState?.save();

  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Processing Data')),
  //     );
  //   }
  // }

  double getPercentage(double percentage, double size) {
    return ((percentage / 100) * size);
  }
}
