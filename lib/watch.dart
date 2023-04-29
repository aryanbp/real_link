import 'package:flutter/material.dart';
import 'main.dart';
class watch extends StatelessWidget {
  const watch({Key? key}) : super(key: key);



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
                  device(img: "w3pro.png", title: "Watch 3 Pro")
                ],
              ),

            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img:"w3.png" , title:"Watch 3")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "wtc.jpg", title: "TechLife S100"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "wband2.png", title: "Band 2"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "w2pro.png", title: "Watch 2 Pro"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "w2.png", title: "Watch 2"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "wspro.png", title: "Watch S Pro"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "wsm.png", title: "Watch S Master")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                device(img: "ws.jpg", title: "Watch S")
              ],
            ),

          ],

        ),
      ),
    );
  }
}
