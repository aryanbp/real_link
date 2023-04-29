import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  final String name;
  final String phone;

  CurrentUser({required this.name,required this.phone});
}

class UserData {

  Future<CurrentUser> getCurrentUserData() async {
    final phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    if (phoneNumber != null) {
      final querySnapshot = await FirebaseFirestore.instance.collection('users')
          .where('Phone', isEqualTo: phoneNumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final userDocument = querySnapshot.docs.first;
        final data = userDocument.data();
        return CurrentUser(
          name: data['Name'] as String,
          phone: data['Phone'] as String,
        );
      }
      else {
        // Handle the case where the document does not exist
        throw Exception('User document does not exist');
      }
    }
    else {
      // Handle the case where the user is not signed in
      throw Exception('User is not signed in');
    }
  }}