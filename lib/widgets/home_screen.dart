import 'package:flutter/material.dart';
import 'package:my_firebase/auth/auth_setup.dart';
import 'package:my_firebase/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final _auth = AuthSetup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),],),


      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Home Screen!',
                style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              Text(
                'You are successfully logged in!',
                style: TextStyle(fontSize: 18,
                    color: Colors.grey[600]),
              ),

              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async{
                  await _auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context)=>LoginScreen())) ;
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  backgroundColor: Colors.blueAccent,),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
