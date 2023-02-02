import 'package:flutter/material.dart';
import 'package:socialapp/view/screens/auth/signIn.dart';
import 'package:socialapp/view/screens/auth/signup.dart';
import 'package:socialapp/view/widgets/NavigateTo.dart';
import 'package:socialapp/view/widgets/button.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1512036849132-48508f294900?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTN8fG5hdHVyYWx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'))),
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const Text(
                  '"Welcome To our community for freedom opinions."',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
               const Spacer(),
                Button(
                    title: 'dont have an account sign up',
                    press: () {
                      To(context, route: SignUpScreen());
                    }),
               const SizedBox(
                  height: 16,
                ),
                Button(title: 'i have an account sign in', press: () {
                  To(context, route: SignInScreen());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
