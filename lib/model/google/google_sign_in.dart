import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


String name;
String email;
String imageUrl;
String googleId;


Future<String> signInWithGoogle() async {
  print("Into Google sign In");
  await Firebase.initializeApp();
  print("Firebase Intialized");
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  print("Google signin account");
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  print("Google signin account credentials ${credential}");
  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  print('${user}');
  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    // Store the retrieved data
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    googleId = user.uid;
    //logindata.setBool('login', false);
    //logindata.setString('username', user.email);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }
  return null;
}
Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}