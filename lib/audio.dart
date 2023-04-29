import 'package:flutter/material.dart';
import 'main.dart';
class audio extends StatelessWidget {
  const audio({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              child: Row(
                children: [
                  device(img: "BA3.png", title: "Buds Air 3")
                ],
              ),

            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img:"BA3S.png" , title:"Buds Air 3S")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BA3N.png", title: "Buds Air 3 Neo"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BTC.png", title: "TechLife Buds"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BA2.png", title: "Buds Air 2"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BWPRO.jpg", title: "Wireless Pro"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BQ.jpg", title: "Buds Q"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BAPRO.jpg", title: "Buds Air Pro")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "BQN.png", title: "Buds Q2 Neo")
              ],
            ),

          ],

        ),
      ),
    );
  }
}
