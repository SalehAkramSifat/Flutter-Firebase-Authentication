import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_firebase/auth/auth_setup.dart';
import 'package:my_firebase/auth/login_screen.dart';

import '../widgets/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = AuthSetup();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  bool _agreeToTerms = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Sign up to get started!',
                style: TextStyle(fontSize: 16,
                    color: Colors.grey[600]),
              ),
              SizedBox(height: 20),

      //Full Name Input=============================================
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 15),

      //Email Input=============================================
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),),),

              SizedBox(height: 15),

        // Password input========================================
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),),),

              SizedBox(height: 15),

        // Confirm Password input ==================================
              TextField(
                controller: _confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),),),


              SizedBox(height: 10),

        // Checkbox for Terms & Conditions ==========================
              Row(children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },),

                  Flexible(
                    child: Text('I agree to the Terms & Conditions'),
                  ),],),

        //SignUp Button ================================================
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child:ElevatedButton(
                  onPressed: () {
                    _signup();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blueAccent,),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),),),


              SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Already have an account? Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to navigate to Home =========================================
  gotoHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),);

  // Function to navigate to Login Page ====================================
  gotoLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),);

  // Signup logic
  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      gotoLogin(context);
    }
  }
}