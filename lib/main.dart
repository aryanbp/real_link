import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:real_link/firebase_options.dart';

import 'aboutus.dart';
import 'login.dart';
import 'app.dart';
import 'mall.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Home());
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool loggedIn = FirebaseAuth.instance.currentUser != null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Home",
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastDark(),
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system,
      home: loggedIn ? homepage() : login(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  static List _data = [];
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  int index = 0;
  final List<Widget> _children = [
    mainpage(),
    //mall(),
    aboutus(),
  ];

  bluescanner() async {
    print("bluescanner");
    try {
      if (_scanning) {
        await _bluetooth.stopScan();
        debugPrint("scanning stoped");
        setState(() {});
      } else {
        await _bluetooth.startScan(pairedDevices: false);
        debugPrint("scanning started");
        setState(() {
          _scanning = false;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.shade100,
        title: Text("Smart Home",style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                _bluetooth.devices.listen((device) {
                  if (!_data.contains(device) && device.paired) {
                    _data.add(device);
                  }
                });
                _bluetooth.scanStopped.listen((device) {
                  _scanning = true;
                  //_data.add('scan stopped\n');
                });
                bluescanner();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const App()));
              },
              icon: Icon(Icons.add,color: Colors.black,)),
        ],
      ),
      body: Column(
        children: [
          _children[index],
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            //NavigationDestination(icon:Icon(Icons.shopping_bag_outlined), label: "Mall"),
            NavigationDestination(
                icon: Icon(Icons.account_circle_rounded), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

class mainpage extends StatefulWidget {
  const mainpage({
    Key? key,
  }) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  static List _data = [];
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();

  @override
  void initState() {
    super.initState();

    _bluetooth.devices.listen((device) {
      if (!_data.contains(device) && device.paired) {
          _data.add(device);
      }
    });
    _bluetooth.scanStopped.listen((device) {
        _scanning = true;
        //_data.add('scan stopped\n');
    });
    bluescanner();
  }

  bluescanner() async {
    print("bluescanner");
    try {
      if (_scanning) {
        await _bluetooth.stopScan();
        debugPrint("scanning stoped");
        setState(() {});
      } else {
        await _bluetooth.startScan(pairedDevices: true);
        debugPrint("scanning started");
        setState(() {
          _scanning = false;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 47, top: 13),
                  child: Text(
                    "My Devices",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0,top:20),
              //   child: Row(
              //     children: [
              //       smartdevice(img: "download.jpg", title: "Smart  Bulb",subtitle: "Working",),
              //       SizedBox(width: 20,),
              //       smartdevice(img: "cam.jpg", title: "Smart Camera",subtitle:"Working",)
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 11.0),
              //   child: Row(
              //     children: [
              //       smartdevice(img: "rob.jpg", title: "Smart Robot",subtitle: "Working",),
              //       SizedBox(width: 20,),
              //       smartdevice(img: "watch.png", title: "Smart Watch",subtitle:"Working",)
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    if (index%2==0 && index!=_data.length) {
                      return screenDevice(_data[index],_data[index+1]);
                    }
                    else{
                      return SizedBox(height:20,);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

screenDevice(BluetoothDevice data,BluetoothDevice data1) {
  print(data);
  return Padding(
    padding: const EdgeInsets.only(left: 11.0),
    child: Row(
      children: [
        smartdevice(
          img: "rob.jpg",
          title: data.name,
          subtitle: "Paired",
          arr:data,
        ),
        SizedBox(
          width: 20,
        ),
        smartdevice(
          img: "watch.png",
          title: data1.name,
          subtitle: "Paired",
          arr:data1,
        )
      ],
    ),
  );
}

class smartdevice extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final BluetoothDevice arr;
  const smartdevice(
      {Key? key,
      required this.img,
      required this.title,
      required this.subtitle, required this.arr,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/" + img,
                  height: 50,
                  width: 50,
                ),
                IconButton(
                    onPressed: () {
                      AppSettings.openBluetoothSettings();

                      },
                    icon: Icon(
                      Icons.power_settings_new_outlined,
                      color: Colors.indigoAccent,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10.0),
            child: Text(
              subtitle,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class device extends StatelessWidget {
  final String img;
  final String title;
  const device({
    Key? key,
    required this.img,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        height: 80,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Image.asset(
                      "assets/" + img,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: IconButton(
                      onPressed: () { AppSettings.openBluetoothSettings();},
                      icon: Icon(Icons.add_card_rounded),
                      color: Colors.black38,
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
