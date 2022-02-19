import 'dart:ui';

import 'package:movie_ticket_booking/Booking/booking_page.dart';
import 'package:movie_ticket_booking/const/const.dart';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobilecontoller = TextEditingController();

  TextEditingController passwordcontoller = TextEditingController();

  String text = '';
  bool passvisibile = true;

  final _signinkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: SafeArea(
        child: Container(
          decoration: background(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: const Text(
                        'Login.',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _signinkey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40),
                        const Center(
                            child: Icon(
                          Icons.slow_motion_video,
                          size: 80,
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 75,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: mobilecontoller,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              errorStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.cyan[300]!)),
                              prefixIcon: const Icon(Icons.phone_android,
                                  color: Colors.black54),
                              suffixIcon: text.isNotEmpty
                                  ? GestureDetector(
                                      child: const Icon(Icons.close,
                                          color: Colors.black54),
                                      onTap: () {
                                        setState(() {
                                          text = '';
                                        });
                                        mobilecontoller.clear();
                                      },
                                    )
                                  : null,
                              hintText: 'Mobile Number',
                            ),
                            onChanged: (value) {
                              setState(() {
                                text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        // SizedBox(height: 5),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 75,
                          child: TextFormField(
                            obscureText: passvisibile,
                            controller: passwordcontoller,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              errorStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.cyan[300]!)),
                              prefixIcon: const Icon(Icons.lock_outline_rounded,
                                  color: Colors.black54),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                    passvisibile
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black54),
                                onTap: () {
                                  //passwordcontoller.clear();
                                  setState(() {
                                    passvisibile
                                        ? passvisibile = false
                                        : passvisibile = true;
                                  });
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 10),
                        SizedBox(width: 150, child: button('SignIn', signIn)),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_signinkey.currentState!.validate()) {
      print('Your Name: ${mobilecontoller.text}');
      print('contct name is: ${passwordcontoller.text}');

      if (int.parse(mobilecontoller.text) != 12345) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("User not found."),
              content: Text('Use this number 12345'),
            );
          },
        );
      } else if (passwordcontoller.text != 'admin') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Wrong Password"),
              content: Text('The Password is: admin'),
            );
          },
        );
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BookTicketsPage()));
      }
    }
  }
}
