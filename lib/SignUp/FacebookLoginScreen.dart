import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookLoginScreen extends StatefulWidget {
  @override
  _FacebookLoginScreenState createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  User? _user;

  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        
        setState(() {
          _user = userCredential.user;
        });
      } else {
        print("Facebook login failed: ${result.message}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _logout() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Facebook Login")),
      body: Center(
        child: _user == null
            ? ElevatedButton(
                onPressed: _loginWithFacebook,
                child: Text("Login with Facebook"),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Logged in as ${_user!.displayName}"),
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text("Logout"),
                  ),
                ],
              ),
      ),
    );
  }
}
