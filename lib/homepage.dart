import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/const/const.dart';
import 'package:movie_ticket_booking/forms/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  //script end here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: background(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 50,
                    child: Text(
                      'Movie Ticket Booking',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 97, 96, 96),
                      ),
                    )),
                const SizedBox(height: 20),
                const SizedBox(
                    height: 50,
                    child: Text(
                      'Please Login to book tickets.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 97, 96, 96),
                      ),
                    )),
                const SizedBox(height: 15),

                SizedBox(width: 150, child: button('Login', signIn)),
                const SizedBox(height: 50),
                SizedBox(width: 150, child: button('Signup', signup)),

                //SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void signup() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => SingnUpPage()));
  }
}
