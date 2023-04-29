import 'package:flutter/material.dart';
import 'main.dart';
class appliance extends StatelessWidget {
  const appliance({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 600),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              Container(
                child: Row(
                  children: [
                    device(img: "rob.jpg", title: "Smart Robot")
                  ],
                ),

              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  device(img:"scale.jpg" , title:"Smart Scale")
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  device(img: "tb.jpg", title: "Smart ToothBrush"),
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }
}
