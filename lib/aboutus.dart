import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_link/login.dart';
import 'package:real_link/main.dart';

import 'back.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  UserData userData = UserData();
  CurrentUser? user;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    user = await userData.getCurrentUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Container(
            height: 80,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: ListTile(
              leading: Image.asset(
                "assets/use.jpg",
                height: 50,
                width: 50,
              ),
              title: Text(
                'Name: ${user?.name}',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text('Phone: ${user?.phone}'),
              // trailing: IconButton(
              //   icon: Icon(Icons.arrow_forward_ios),
              //   onPressed: () {},
              // ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 70,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Image.asset(
                  "assets/update.jpg",
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  'Firmware Update',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Image.asset(
                  "assets/help.jpg",
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  'Help and Feedback',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    print("Uwe");
                    print(FirebaseAuth.instance.currentUser);
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Image.asset(
                  "assets/set.png",
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    AppSettings.openAppSettings();
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Image.asset(
                  "assets/log.png",
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  'SignOut',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) =>login()),
                        (route) => false);
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
