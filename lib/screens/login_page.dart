import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    try {
      final AuthSession session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        _forceLogout();
      }
    } catch (e) {
      _forceLogout();
      print('Error checking login status: $e');
    }
  }

  Future<void> _forceLogout() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      print("Error trying to log out: $e");
    }
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar:
          AppBar(title: const Text('Login'), backgroundColor: Colors.white10),
      body: Stack(
        children: [
          // Black background
          Container(
            color: Colors.white10,
          ),
          // Login form
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      cursorColor: Color(0xFF66FFCC),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.email, color: Color(0xFF66FFCC)),
                        fillColor: Colors.white10.withOpacity(0.2),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF66FFCC)),
                        fillColor: Colors.white.withOpacity(0.2),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: deviceSize.height * 0.01),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: TextStyle(
                            fontFamily: 'GameFont',
                          ),
                        ),
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          final SignInResult res = await Amplify.Auth.signIn(
                            username: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          if (res.isSignedIn) {
                            Navigator.pushReplacementNamed(context, '/profile');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Login failed. Please try again.'),
                                backgroundColor: Color(0xFF66FFCC),
                              ),
                            );
                          }
                        } on AuthException catch (e) {
                          // _forceLogout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message),
                              backgroundColor: Color(0xFF66FFCC),
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF66FFCC),
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceSize.width * 0.3, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: TextStyle(
                          fontFamily: 'GameFont',
                          fontSize: 18,
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF66FFCC)),
                            )
                          : const Text('Login'),
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: TextButton.styleFrom(
                        primary: Color.fromARGB(255, 0, 0, 0),
                        textStyle: TextStyle(
                          fontFamily: 'GameFont',
                        ),
                      ),
                      child: const Text('Create an account'),
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "or continue with",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Google login logic
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.google,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            // Facebook login logic
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.facebook,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
