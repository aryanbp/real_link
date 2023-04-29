import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:draggable_fab/draggable_fab.dart';

import 'main.dart';

class Me extends StatelessWidget {
  const Me({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //Main
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //First Box
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        "Umar Shaikh",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "4 Devices",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Second Box
            Container(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 15, left: 20),
                      child: Container(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.message,
                              color: Colors.orangeAccent,
                              size: 40,
                            ),
                            Text(
                              'Notification',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 15, left: 15),
                      child: Container(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.note_alt_sharp,
                              color: Colors.green,
                              size: 40,
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 15, right: 15),
                      child: Container(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.question_answer,
                              color: Colors.purple,
                              size: 40,
                            ),
                            Text(
                              'Features',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Third Box

            Container(

              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_circle_up_outlined,
                          color: Colors.blue,
                        ),
                        Text('Firewall Update'),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),


                ],

              ),
            ),


            const Text(
              'Your Info',
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          const Spacer(),
      FloatingActionButton(
              onPressed: () async {

// Get a reference to the Firestore collection
                CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');

                // Get a reference to all the documents in the collection
                QuerySnapshot querySnapshot = await collectionReference.get();

// Loop through all the documents
                for (var documentSnapshot in querySnapshot.docs) {
                  print("Hi");
                  // print(documentSnapshot.id);
                  // Check if the document meets the criteria
                  // if (documentSnapshot.data() == '+91 7045614665') {
                  //
                  //   // Get a reference to the document
                  //   // DocumentReference documentReference = collectionReference.doc(documentSnapshot.get('UNO'));
                  //   //
                  //   // // Delete the document
                  //   // await documentReference.delete();
                  // }
                }

                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                            )));
              },
              child: const Icon(Icons.logout),
            ),
          const Spacer(),
      FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_left),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
