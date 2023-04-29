import 'package:flutter/material.dart';
import 'main.dart';
class lighting extends StatelessWidget {
  const lighting({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),

              Container(
                child: Row(
                  children: [
                    device(img: "download.jpg", title: "Smart Bulb"),
                  ],
                ),

              ),


            ],

          ),
        ),
      ),
    );
  }
}
