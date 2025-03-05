import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase/widgets/wrapper.dart';

import '../auth/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyCBALQ-UAsNRfaLoJzqLSBor9kbqDTbxqQ",
        authDomain: "fire-setup-c44f3.firebaseapp.com",
        projectId: "fire-setup-c44f3",
        storageBucket: "fire-setup-c44f3.firebasestorage.app",
        messagingSenderId: "151420649379",
        appId: "1:151420649379:web:08a29a0a21747d6a53e416"));
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: Wrapper());
  }
}

