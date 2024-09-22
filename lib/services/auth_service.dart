import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //google sign in
  signInWithGoogle() async {
    //interactive sign process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth detail from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //new credential for user

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //done
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
