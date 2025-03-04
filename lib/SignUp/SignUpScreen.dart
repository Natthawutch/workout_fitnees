import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Helper method to show error messages
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(fontFamily: "Georgia")),
        content: Text(message, style: TextStyle(fontFamily: "Georgia")),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK",
                style:
                    TextStyle(fontFamily: "Georgia", color: Colors.blue[700])),
          ),
        ],
      ),
    );
  }

  // Helper method to show success messages
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Parse Firebase Auth errors into user-friendly messages
  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The sign-in credential is invalid.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection and try again.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }

  Future<void> _signUpWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _showSuccessSnackBar("Account Created Successfully!");
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _getFirebaseErrorMessage(e));
      _showErrorDialog("Sign-Up Failed", _getFirebaseErrorMessage(e));
    } catch (e) {
      setState(() => _errorMessage = e.toString());
      _showErrorDialog(
          "Sign-Up Failed", "An unexpected error occurred. Please try again.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return; // User canceled the sign-in flow
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      _showSuccessSnackBar("Signed in with Google!");
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _getFirebaseErrorMessage(e));
      _showErrorDialog("Google Sign-In Failed", _getFirebaseErrorMessage(e));
    } catch (e) {
      setState(() => _errorMessage = e.toString());
      _showErrorDialog("Google Sign-In Failed",
          "An error occurred during Google sign-in. Please try again.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithApple() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      _showSuccessSnackBar("Signed in with Apple!");
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _getFirebaseErrorMessage(e));
      _showErrorDialog("Apple Sign-In Failed", _getFirebaseErrorMessage(e));
    } catch (e) {
      setState(() => _errorMessage = e.toString());
      _showErrorDialog("Apple Sign-In Failed",
          "An error occurred during Apple sign-in. Please try again.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithICloud() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // This is a placeholder - iCloud authentication would need to be implemented
      // based on your specific requirements and authentication setup
      _showErrorDialog(
          "iCloud Sign-In", "iCloud sign-in is not yet implemented.");
    } catch (e) {
      setState(() => _errorMessage = e.toString());
      _showErrorDialog("iCloud Sign-In Failed",
          "An error occurred during iCloud sign-in. Please try again.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Continue with",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: "Georgia",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 24),

                  // Error Message (if any)
                  if (_errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontFamily: "Georgia",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close,
                                color: Colors.red.shade300, size: 18),
                            onPressed: () =>
                                setState(() => _errorMessage = null),
                          ),
                        ],
                      ),
                    ),

                  // Social Sign-in Buttons
                  Column(
                    children: [
                      // Apple Sign In (แสดงเฉพาะบน iOS)
                      if (Platform.isIOS) // ตรวจสอบว่าเป็น iOS หรือไม่
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 16),
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _signInWithApple,
                            icon: Icon(Icons.apple, size: 24),
                            label: Text(
                              "Sign in with Apple",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Georgia",
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                    color: Colors.white.withOpacity(0.2)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                          ),
                        ),

                      // iCloud Sign In (แสดงเฉพาะบน iOS)
                      if (Platform.isIOS) // ตรวจสอบว่าเป็น iOS หรือไม่
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 16),
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _signInWithICloud,
                            icon: Icon(Icons.cloud, size: 24),
                            label: Text(
                              "iCloud",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Georgia",
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                          ),
                        ),

                      // Google Sign In (แสดงบนทุก Platform)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 24),
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _signInWithGoogle,
                          icon: Icon(Icons.g_mobiledata, size: 24),
                          label: Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Georgia",
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                          ),
                        ),
                      ),

                      // Others dropdown (แสดงบนทุก Platform)
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) => Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.email,
                                              color: Colors.white),
                                          title: Text("Sign in with Email",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Georgia")),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Show email sign in form
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone,
                                              color: Colors.white),
                                          title: Text("Sign in with Phone",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Georgia")),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Show phone sign in form
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Others",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Georgia",
                                color: Colors.white,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                color: Colors.white),
                          ],
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          disabledForegroundColor:
                              Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),

            // Loading Overlay
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
