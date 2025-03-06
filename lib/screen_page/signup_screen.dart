import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_firebase/auth/auth_setup.dart';
import 'package:my_firebase/screen_page/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = AuthSetup();

  TextEditingController _emailOrPhone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailOrPhone.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  bool _isPhoneNumber(String input) {
    final phoneRegExp = RegExp(r'^(?:\+880|0)1[3-9][0-9]{8}$');
    return phoneRegExp.hasMatch(input);
  }

  // SignUpScreen.dart (After Registering User)
  _signup() async {
    if (_emailOrPhone.text.trim().isEmpty || _password.text.trim().isEmpty) {
      return;
    }

    try {
      final user = await _auth.createUserWithEmailAndPassword(
          _emailOrPhone.text.trim(), _password.text.trim());

      if (user == null) {
        return;
      }

      // Send verification email
      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification email sent. Please check your inbox.")));

      // Redirect to Login Screen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView( // স্ক্রলভিউ যুক্ত করা হলো
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent)),

                SizedBox(height: 20),

                // Email/Phone Input
                TextFormField(
                  controller: _emailOrPhone,
                  keyboardType: _isPhoneNumber(_emailOrPhone.text)
                      ? TextInputType.phone
                      : TextInputType.emailAddress, // ইনপুট টাইপ ডায়নামিক
                  decoration: InputDecoration(
                    labelText: 'Email or Phone (017XXXXXXXX)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9@.+-_a-zA-Z]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter Email or Phone";
                    if (!_isPhoneNumber(value) && !value.contains('@')) return "Enter a valid Email or Phone";
                    return null;
                  },
                ),

                SizedBox(height: 15),

                // Password Input
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) => value != null && value.length < 6 ? "Password must be at least 6 characters" : null,
                ),

                SizedBox(height: 15),

                // Confirm Password Input
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) => value != _password.text ? "Passwords do not match" : null,
                ),

                SizedBox(height: 10),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signup, // লোডিং হলে ডিজেবল
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),

                SizedBox(height: 15),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text("Already have an account? Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
