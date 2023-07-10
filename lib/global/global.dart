import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth fauth = FirebaseAuth.instance;
final FirebaseFirestore ffire = FirebaseFirestore.instance;
String? photourl;

// ignore: non_constant_identifier_names
GoogleSignInAccount? GoogleUser;
// ignore: non_constant_identifier_names
Map<String, dynamic>? FacebookUser;
// ignore: non_constant_identifier_names
UserCredential? NormalUser;

var currentFirebaseUser = FirebaseAuth.instance.currentUser;
UserCredential? userCred;
bool load = false;

bool isinrequestmode = false;


String? userKey;


DateTime? currentBackPressTime;


String? Role;

String? sany3yWarsha;


bool? SignedIn;

bool? elwarshaState;

