import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

import 'me.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link App',
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme(
          const TextTheme(
            bodyText2: TextStyle(color: Colors.white),
          ),
        ),
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ThirdScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SecondScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            const Text('Real_Link',
                style: TextStyle(color: Colors.purple, fontSize: 50)),
          ],
        ),
      ),
      // color: Colors.black,
      // child: Icon(
      //   Icons.connect_without_contact_sharp,
      //   color: Colors.deepPurple,
      //   size: 300,
      // )
      //FlutterLogo(size:MediaQuery.of(context).size.height,textColor: Colors.purple,)
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final mycon = TextEditingController(text: '+91 7045614665');

  String textholde = "Enter Your Phone No:";
  String smsCode = '';
  String verf = '';
  int val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login Page',
          style: GoogleFonts.ubuntu(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(textholde, style: const TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purpleAccent),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: mycon,
                ),
              ),
            ),
            TextButton(
                onPressed: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  if (val == 0) {
                    val = 1;
                    setState(() {
                      textholde = 'Authenticating...';
                    });
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: mycon.text,
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        // ANDROID ONLY!

                        // Sign the user in (or link) with the auto-generated credential
                        //await auth.signInWithCredential(credential);
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          setState(() {
                            textholde =
                                'The provided phone number is not valid.';
                          });
                        }

                        // Handle other errors
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        // Update the UI - wait for the user to enter the SMS code
                        setState(() {
                          textholde = 'Enter OTP: ';
                        });
                        mycon.clear();
                        verf = verificationId;

                        // Create a PhoneAuthCredential with the code
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // Auto-resolution timed out...
                      },
                    );
                  } else {
                    val = 0;
                    smsCode = mycon.text;
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verf, smsCode: smsCode);
                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    setState(() {
                      //textholde = 'Done!!!! ';
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ThirdScreen()));
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purpleAccent),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Click Me',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Me(title: 'Me')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Page',
          style: GoogleFonts.ubuntu(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Welcome Home:',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.deepPurpleAccent,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Colors.deepPurpleAccent,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.deepPurpleAccent,
            ),
            label: ' Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
