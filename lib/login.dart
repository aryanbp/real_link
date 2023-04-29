import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:real_link/main.dart';

class login extends StatelessWidget {
   login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final otpController = TextEditingController();
    final nameController = TextEditingController();

    var code;
    String verid="";
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80,),
              Container(
                child: Image.asset("assets/av.png",height: 150,width: 150,),

                ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 280,
                          height:50,
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.white),
                                icon: Icon(Icons.people),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:1,color:Colors.white),
                                )

                            ),
                            controller: nameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 280,
                          height:50,
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: "Phone No",
                                icon: Icon(Icons.phone),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:1,color:Colors.white),
                                )

                            ),
                            controller: phoneController,
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height:50,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Enter OTP",
                          icon: Icon(Icons.open_with_outlined),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1,color:Colors.white),
                          )

                      ),
                      controller: otpController,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 80,
                  child:ElevatedButton(onPressed: () async {String verificationId;
                    print('+91' + phoneController.text);
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91' + phoneController.text,
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String _verificationId, int? resendToken) {
                        verificationId = _verificationId;
                        verid= verificationId;
                      },
                      codeAutoRetrievalTimeout: (String _verificationId){},
                      );
                  print("OTP Sent");
                  }, child: Text("GET OTP",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),)
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SizedBox(
                    height: 50,
                    width: 130,
                    child:ElevatedButton(onPressed: () async {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verid, smsCode: otpController.text);
                      await FirebaseAuth.instance.signInWithCredential(credential);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => homepage()));
                      await FirebaseFirestore.instance.collection("users").add({
                        'Name': nameController.text,
                        'Phone': '+91' + phoneController.text,
                      });
                    }, child: Text("LOGIN",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),)
                ),
                ],
              ),

              SizedBox(height: 200,),
                  ]

              ),
        ),
      ),
    );
  }
}
