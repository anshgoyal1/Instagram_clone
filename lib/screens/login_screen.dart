import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/screens/registration_screen.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/widgets/text_field_input.dart';

import '../resourses/auth_methods.dart';
import '../responsive_layout/mobile_screen_layout.dart';
import '../responsive_layout/responsive_layout.dart';
import '../responsive_layout/web_screen_layout.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == 'success') {
    } else {
      showSnackBar(res, context);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                height: 64,
                color: primaryColor,
              ),

              SizedBox(
                height: 64,
              ),
              //email text field

              TextFieldInput(
                  controller: _emailController,
                  hint: 'Enter your email',
                  textInputType: TextInputType.emailAddress),

              const SizedBox(
                height: 24,
              ),

              //password text field
              TextFieldInput(
                  controller: _passwordController,
                  isPass: true,
                  hint: 'Enter your password',
                  textInputType: TextInputType.visiblePassword),

              const SizedBox(
                height: 24,
              ),

              //login button

              GestureDetector(
                child: Container(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    color: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                onTap: loginUser,
              ),

              SizedBox(
                height: 12,
              ),

              Flexible(child: Container(), flex: 2),
              Row(
                children: [
                  Container(
                    child: Text("Don't you have an account?"),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
