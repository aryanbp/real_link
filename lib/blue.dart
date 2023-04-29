import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'main.dart';

class blue extends StatefulWidget {
  const blue({Key? key}) : super(key: key);
  static List up_data = [];

  @override
  State<blue> createState() => _blueState();
}

class _blueState extends State<blue> {
  bool _scanning = false;

  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();

  @override
  void initState() {
    super.initState();

    _bluetooth.devices.listen((device) {
      if (!blue.up_data.contains(device)) {
        print("od");
        blue.up_data.add(device);
      }
    });
    _bluetooth.scanStopped.listen((device) {
      _scanning = false;
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
        await _bluetooth.startScan(pairedDevices: false);
        debugPrint("scanning started");
        setState(() {
          _scanning = true;
        });
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  upDevices(BluetoothDevice data) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Container(
        child: Row(
          children: [device(img: "w3pro.png", title: data.name)],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 680,
        child: ListView.builder(
          itemCount: blue.up_data.length,
          itemBuilder: (context, index) {
            return upDevices(blue.up_data[index]);
          },
        ),
      ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img:"w3.png" , title:"Watch 3")
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "wtc.jpg", title: "TechLife S100"),
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "wband2.png", title: "Band 2"),
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "w2pro.png", title: "Watch 2 Pro"),
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "w2.png", title: "Watch 2"),
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "wspro.png", title: "Watch S Pro"),
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "wsm.png", title: "Watch S Master")
      //   ],
      // ),
      // SizedBox(height: 20,),
      // Row(
      //   children: [
      //     device(img: "ws.jpg", title: "Watch S")
      //   ],
      // ),
      //
      //   ],
      //
      // ),
    );
  }
}
