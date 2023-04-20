import 'package:chat_up/apis/apis.dart';
import 'package:chat_up/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../utils/global_variable.dart';
import 'home_screen.dart';

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
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await APIs().loginUser(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString());
    if (res == "Success") {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    bool _isWeb = false;
    setState(() {
      if (size > 600) {
        _isWeb = true;
      } else {
        _isWeb = false;
      }
    });

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: _isWeb ? Colors.grey.shade300 : Colors.white,
          body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: _isWeb
                  ? Row(
                      children: [
                        Container(
                          width: size / 2 - 24,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 26,
                              ),
                              Container(
                                height: 26,
                                width: 400,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                    ),
                                    FadeAnimation(
                                      1.1,
                                      Image.asset(
                                        "assets/images/logo.png",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    FadeAnimation(
                                      1.2, Text(
                                        "Chat Up",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pink),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 26,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Container(
                                      width: size / 2 - 110,
                                      child: FadeAnimation(
                                        1.3, Text(
                                          "# No. 1 Real time chatting application developed by Anurag Kashyap",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black87,
                                              fontSize: 22,
                                              letterSpacing: 0.4),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: FadeAnimation(
                                    1.4,
                                    Container(
                                        width: 400,
                                        height: 400,
                                        child: Icon(
                                          Icons.mark_unread_chat_alt_outlined,
                                          size: 160,
                                          color: Colors.pink,
                                        ),)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size <= 1160 ? 80 : 120,
                        ),
                        Container(
                          width: 460,
                          height: 650,
                          padding: EdgeInsets.all(32),
                          child: FadeAnimation(
                            1.5, PhysicalModel(
                              color: Colors.white,
                              elevation: 8,
                              shadowColor: Colors.blue,
                              borderRadius: BorderRadius.circular(26),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    FadeAnimation(
                                      1.6, Text(
                                        "User Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            letterSpacing: 0.4,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: 300,
                                      child: FadeAnimation(
                                        1.7, Text(
                                          "Hey, Enter your details to get sign in to your account",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    FadeAnimation(
                                        1.8,
                                        TextField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _emailController,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Colors.pink,
                                            ),
                                            hintText: "Enter your Email",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.pink.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    FadeAnimation(
                                        1.9,
                                        TextField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          controller: _passwordController,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.fingerprint,
                                              color: Colors.pink,
                                            ),
                                            hintText: "Enter your Password",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.pink.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: FadeAnimation(
                                          2.0, Text(
                                            "Having trouble in sign in ?",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        height: 46,
                                        child: FadeAnimation(
                                            2.1,
                                            ElevatedButton(
                                                onPressed: () {
                                                  loginUser();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.pink,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    )),
                                                child:  _isLoading
                                                    ? Center(
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                                    : Text(
                                                    "Sign In".toUpperCase()),))),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: FadeAnimation(
                                            2.2, Container(
                                              height: 1,
                                              width: 40,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        FadeAnimation(
                                          2.3, Center(
                                              child: Text(
                                            "  or  ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        FadeAnimation(
                                          2.4, Center(
                                            child: Container(
                                              height: 1,
                                              width: 40,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FadeAnimation(
                                          2.5, Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.black54)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Google",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.facebook,
                                                    color: Colors.pink,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        FadeAnimation(
                                          2.6, Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.black54)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "facebook",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.facebook,
                                                    color: Colors.pink,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        FadeAnimation(
                                          2.7, Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.black54)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Apple Id",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.apple_rounded,
                                                    color: Colors.pink,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 36,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FadeAnimation(
                                              2.8, Text(
                                                "Don't have an account?",
                                                style:
                                                    TextStyle(color: Colors.black87),
                                              ),
                                            ),
                                            FadeAnimation(
                                              2.9, Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: size - 60,
                                height: 580,
                                padding: EdgeInsets.all(0),
                                child: FadeAnimation(
                                  1.1, PhysicalModel(
                                    color: Colors.white,
                                    elevation: 8,
                                    shadowColor: Colors.blue,
                                    borderRadius: BorderRadius.circular(26),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          FadeAnimation(
                                            1.2, Text(
                                              "User Login",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  letterSpacing: 0.4,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 300,
                                            child: FadeAnimation(
                                              1.3, Text(
                                                "Hey, Enter your details to get sign in to your account",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 26,
                                          ),
                                          FadeAnimation(
                                              1.4,
                                              TextField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: _emailController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.email,
                                                    color: Colors.pink,
                                                  ),
                                                  hintText: "Enter your Email",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .pink.shade300),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          FadeAnimation(
                                              1.4,
                                              TextField(
                                                keyboardType:
                                                    TextInputType.visiblePassword,
                                                controller: _passwordController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.fingerprint,
                                                    color: Colors.pink,
                                                  ),
                                                  hintText: "Enter your Password",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .pink.shade300),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: FadeAnimation(
                                                1.5, Text(
                                                  "Having trouble in sign in ?",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 26,
                                          ),
                                          SizedBox(
                                              width: double.infinity,
                                              height: 46,
                                              child: FadeAnimation(
                                                  1.6,
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        loginUser();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.pink,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              )),
                                                      child:  _isLoading
                                                          ? Center(
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                          : Text(
                                                          "Sign In".toUpperCase()),))),
                                          SizedBox(
                                            height: 26,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              FadeAnimation(
                                                1.8, Center(
                                                  child: Container(
                                                    height: 1,
                                                    width: 40,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                  child: Text(
                                                "  or  ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                              Center(
                                                child: Container(
                                                  height: 1,
                                                  width: 40,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 26,
                                          ),
                                          Row(
                                            children: [
                                              FadeAnimation(
                                                1.9, Container(
                                                  width: size / 4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8),
                                                      border: Border.all(
                                                          color: Colors.black54)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 1,
                                                            vertical: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Google",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Icon(
                                                          Icons.facebook,
                                                          color: Colors.pink,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              FadeAnimation(
                                                2.0, Container(
                                                  width: size / 4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8),
                                                      border: Border.all(
                                                          color: Colors.black54)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 1,
                                                            vertical: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "facebook",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Icon(
                                                          Icons.facebook,
                                                          color: Colors.pink,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              FadeAnimation(
                                                2.1, Container(
                                                  width: size / 4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8),
                                                      border: Border.all(
                                                          color: Colors.black54)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 1,
                                                            vertical: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Apple Id",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        Icon(
                                                          Icons.apple_rounded,
                                                          color: Colors.pink,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 36,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FadeAnimation(
                                                    2.2, Text(
                                                      "Don't have an account?",
                                                      style: TextStyle(
                                                          color: Colors.black87),
                                                    ),
                                                  ),
                                                  FadeAnimation(
                                                    2.3, Text(
                                                      "Sign Up",
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ))),
    );
  }
}
