import 'package:flutter/material.dart';

class mall extends StatelessWidget {
  const mall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child:Column(
          children: [
            Container(
              color: Colors.black,
              height: 50,
              width: 800,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/phoenix.png",height: 50,width: 50,),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      height: 50,
                      width: 150,
                    child:TextField(
                      decoration: InputDecoration(
                          labelText: "Search Here...",
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width:1,color:Colors.white),
                          )

                      ),
                    ),
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined))
                ],
              ),


            ),
            Container(
              height: 80,
              width: 800,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Image.asset("assets/watch.png")),
                ],
              ),
            )
          ],
        ),
    );
  }
}
