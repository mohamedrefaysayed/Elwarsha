import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth fauth = FirebaseAuth.instance;
final FirebaseFirestore ffire = FirebaseFirestore.instance;
String? photourl = null;

GoogleSignInAccount? GoogleUser;
Map<String, dynamic>? FacebookUser;
UserCredential? NormalUser;

var currentFirebaseUser = FirebaseAuth.instance.currentUser;
UserCredential? userCred;
bool load = false;

bool isinrequestmode = false;


String? userKey;


DateTime? currentBackPressTime;

