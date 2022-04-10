import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/resourses/auth_methods.dart';
import 'package:fluttergram/screens/login_screen.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive_layout/mobile_screen_layout.dart';
import '../responsive_layout/responsive_layout.dart';
import '../responsive_layout/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _profileImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        userName: _usernameController.text,
        bio: _bioController.text,
        file: _profileImage!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

              //circular widget to show and place image

              Stack(
                children: [
                  _profileImage != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_profileImage!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png'),
                        ),
                  Positioned(
                    child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          selectImage();
                        }),
                    bottom: -10,
                    left: 80,
                  ),
                ],
              ),
              SizedBox(
                height: 64,
              ),
              //username text field
              TextFieldInput(
                  controller: _usernameController,
                  hint: 'Enter your username',
                  textInputType: TextInputType.text),

              const SizedBox(
                height: 24,
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

              //bio text field
              TextFieldInput(
                  controller: _bioController,
                  hint: 'Enter your bio',
                  textInputType: TextInputType.text),

              const SizedBox(
                height: 24,
              ),

              //login button

              GestureDetector(
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: const CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : Text('Register'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    color: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                onTap: signUpUser,
              ),

              SizedBox(
                height: 12,
              ),

              Flexible(child: Container(), flex: 2),
              Row(
                children: [
                  Container(
                    child: Text("Already have an account?"),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: Text(
                        "Log in",
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
