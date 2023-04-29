
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'watch.dart';
import 'security.dart';
import 'audio.dart';
import 'lighting.dart';
import 'appliance.dart';
import 'blue.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      theme: ThemeData (
        colorScheme: ColorScheme.highContrastDark(),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: apppage(),
    );
  }
}

class apppage extends StatefulWidget {
  const apppage({Key? key}) : super(key: key);

  @override
  State<apppage> createState() => _apppageState();
}

class _apppageState extends State<apppage> {
  int selectedIndex=0;
  PageController pageController=PageController();
  final List<Widget> _children=[
    blue(),watch(),security(),lighting(),audio(),appliance(),
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent.shade100,
          actions:[IconButton(onPressed: () {
            setState(() {
            });
            Navigator.of(context, rootNavigator: true).pop(context);}, icon: Icon(Icons.exit_to_app_sharp,color: Colors.black,),padding: EdgeInsets.all(10),),],
        leading:
          IconButton(onPressed: () { AppSettings.openAppSettings();}, icon: Icon(Icons.linked_camera_outlined,color: Colors.black,)),

          title: Text("Add Device",style: TextStyle(color: Colors.black),),

        centerTitle: true,
        automaticallyImplyLeading: true,

        ),

        body: Row(
        children: [
            NavigationRail(
              // trailing:IconButton(onPressed: () {Navigator.of(context, rootNavigator: true).pop(context);}, icon: Icon(Icons.exit_to_app_sharp),padding: EdgeInsets.only(top: 30),),
              backgroundColor: Colors.black,
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: IconThemeData(color: Colors.white),
              onDestinationSelected: (newIndex){
                setState(() {
                  selectedIndex = newIndex;
                  pageController.animateToPage(newIndex, duration: Duration(milliseconds: 20), curve: Curves.bounceIn);
                   });
              },


              selectedIndex: selectedIndex,
                destinations:  [
                  NavigationRailDestination(icon: Icon(Icons.bluetooth), label: Text("Bluetooth")),
                  NavigationRailDestination(icon: Icon(Icons.watch_outlined), label: Text("Watch")),
                  NavigationRailDestination(icon: Icon(Icons.security_outlined), label: Text("Security")),
                  NavigationRailDestination(icon: Icon(Icons.lightbulb_rounded), label: Text("Lighting")),
                  NavigationRailDestination(icon: Icon(Icons.audiotrack_outlined), label: Text("Audio")),
                  NavigationRailDestination(icon: Icon(Icons.catching_pokemon), label: Text("Appliances")),
                ],
             ),

          Expanded(child: PageView(
            controller: pageController,
            children: [
              _children[selectedIndex],
            ],
          ))



],
    ));

  }}


  

  
