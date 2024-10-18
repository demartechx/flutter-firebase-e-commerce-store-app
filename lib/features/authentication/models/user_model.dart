


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class UserModel {


 final String id, username, email;
 String firstName, lastName, phoneNumber, profilePicture;

  UserModel({ required this.id, required this.username, required this.email, required this.firstName, required this.lastName, required this.phoneNumber, required this.profilePicture, });


//helper function to get the full name
String get fullName => '$firstName $lastName';

//format phone number

String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

static List<String> nameParts(fullName) => fullName.split(" ");

static String generateUsername(fullName) {
  List<String> nameParts = fullName.split(" ");
  String firstName = nameParts[0].toLowerCase();
  String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

  String camelCaseUsername = "$firstName$lastName";
  String usernameWithPrefix = "cwt_$camelCaseUsername";

  return usernameWithPrefix;
}

//static function to create an empty user model
static UserModel empty() => UserModel(id: '', username: '', email: '', firstName: '', lastName: '', phoneNumber: '', profilePicture: '');

//convert model to json structure for storing data in firebase
Map<String, dynamic> toJson() {
  return {
    'FirstName': firstName,
    'LasttName': lastName,
    'Username': username,
    'Email': email,
    'PhoneNumber': phoneNumber,
    'ProfilePicture': profilePicture,
  };
}

//factory method to create a UserModel from a firebase document snapshot.
// factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//   if (document.data() != null) {
//     final data = document.data()!;
//     return UserModel(id: document.id, username: data['Username'] ?? '', email: data['Email'] ?? '', firstName: data['FirstName'] ?? '', lastName: data['LastName'] ?? '', phoneNumber: data['PhoneNumber'] ?? '', profilePicture: data['ProfilePicture'] ?? '');
//   }
// }


factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data();
  if (data == null) {
    throw Exception('Document data is null');
  }
  return UserModel(
    id: document.id,
    username: data['Username'] ?? '',
    email: data['Email'] ?? '',
    firstName: data['FirstName'] ?? '',
    lastName: data['LastName'] ?? '',
    phoneNumber: data['PhoneNumber'] ?? '',
    profilePicture: data['ProfilePicture'] ?? '',
  );
}






}