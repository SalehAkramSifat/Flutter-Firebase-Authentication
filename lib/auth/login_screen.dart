import 'package:flutter/material.dart';
import 'package:my_firebase/auth/auth_setup.dart';
import 'package:my_firebase/auth/signup_screen.dart';
import 'package:my_firebase/widgets/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  final _auth = AuthSetup();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool _rememberMe = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
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
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please login to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(isPasswordHidden ?
                          Icons.visibility_off : Icons.visibility),
                    onPressed: (){setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });

                    },
                      ),),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember Me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  )
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                   _login();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: Text("Don't have an account? Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  gotoSignUp(BuildContext context) =>Navigator.push(
      context, MaterialPageRoute(
      builder: (context)=> SignUpScreen()));
  gotoHome(BuildContext context) =>Navigator.push(
      context, MaterialPageRoute(
      builder: (context)=>HomeScreen()));

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }


  //Longin Setup==================================================
  _login () async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showError("Please enter email and password");
      return;
    }
    try {
      final user = await _auth.loginUserWithEmailAndPassword(
          _email.text.trim(), _password.text.trim());

      if (user != null) {
        _showSuccess("Login Successful!");
        gotoHome(context);
      } else {
        _showError('Invalid email or password. Please try again.');
      }
    } catch (e) {
      _showError("Error: ${e.toString()}");
    }
  }

}