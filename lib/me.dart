import 'package:flutter/material.dart';
import 'package:draggable_fab/draggable_fab.dart';

class Me extends StatelessWidget {
  const Me({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 50,
                    width: 50,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.black,
                    ),
                    child:Icon(Icons.person,color: Colors.white,),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Umar Shaikh",style: TextStyle(color: Colors.black),),
                        Text("4 Devices",style: TextStyle(color: Colors.grey,fontSize: 11),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Welcome Home.',
            ),
          ],
        ),
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_left),
        ),
      ),
    );
  }
}
