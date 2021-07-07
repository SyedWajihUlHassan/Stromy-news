import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_login_signup/src/signup.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'Widget/bezierContainer.dart';
import 'home.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  // final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // emptyLoginData();
  }

  // emptyLoginData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var email= prefs.getString('email') ?? "";
  //   prefs.setString("email", "");
  //   var pass = prefs.getString('password') ?? "";
  //   prefs.setString("password", "");
  //
  //   print(email);
  //   print(pass);
  // }
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  // Widget _submitButton() {
  //   final String emailValue;
  //   final String passwordValue;
  //
  //   return GestureDetector(
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.symmetric(vertical: 15),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(Radius.circular(5)),
  //           boxShadow: <BoxShadow>[
  //             BoxShadow(
  //                 color: Colors.grey.shade200,
  //                 offset: Offset(2, 4),
  //                 blurRadius: 5,
  //                 spreadRadius: 2)
  //           ],
  //           gradient: LinearGradient(
  //               begin: Alignment.centerLeft,
  //               end: Alignment.centerRight,
  //               colors: [Colors.deepOrange, Colors.orangeAccent])),
  //       child: Text(
  //         'Login',
  //         style: TextStyle(fontSize: 20, color: Colors.white),
  //       ),
  //     ),
  //     onTap: () async {
  //       //after the login REST api call && response code ==200
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       if(emailController.text == "admin@gmail.com" && passwordController.text == "1234")
  //       prefs.setString('email', 'admin@gmail.com');
  //       prefs.setString('password', '1234');
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (BuildContext ctx) => Home()));
  //     },
  //   );
  // }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Stromy',
            style: TextStyle(color: Colors.deepOrange, fontSize: 30)),
        Text(
          'News',
          style: TextStyle(color: Colors.black, fontSize: 30),
        )
      ],
    );
  }

  // Widget _emailPasswordWidget() {
  //   final emailController = TextEditingController();
  //   final passwordController = TextEditingController();
  //   return Column(
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsets.symmetric(vertical: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "Email",
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             TextField(
  //               controller: emailController,
  //                 decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     fillColor: Color(0xfff3f3f4),
  //                     filled: true))
  //           ],
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.symmetric(vertical: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "Password",
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             TextField(
  //               controller: passwordController,
  //                 decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     fillColor: Color(0xfff3f3f4),
  //                     filled: true))
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;


    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .3),
                  _title(),
                  SizedBox(height: 80),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Password",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true))
                      ],
                    ),
                  )
                ],
              ),
                  SizedBox(height: 80),
                  submitButton(emailVal: emailController.text,
                  passwordVal: passwordController.text,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 10),
                  //   alignment: Alignment.centerRight,
                  //   child: Text('Forgot Password ?',
                  //       style: TextStyle(
                  //           fontSize: 14, fontWeight: FontWeight.w500)),
                  // ),

                  // _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}


class submitButton extends StatelessWidget {
  final String emailVal;
  final String passwordVal;
  const submitButton({Key? key, required this.emailVal, required this.passwordVal}) : super(key: key);



  login(context) async {
    //after the login REST api call && response code ==200
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(emailVal == "admin@gmail.com" && passwordVal == "1234"){
      prefs.setString('email', 'admin@gmail.com');
      prefs.setString('password', '1234');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext ctx) => Home()));
    }
    else(){
      print("data is not valid");
    };
  }



  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orangeAccent,
      onTap: () => login(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.deepOrange, Colors.orangeAccent])),
        child: Text(
          'Login Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}



// class submitButton extends StatefulWidget {
//   final String emailVal;
//   final String passwordVal;
//   const submitButton(this.emailVal, this.passwordVal);
//
//   @override
//   _submitButtonState createState() => _submitButtonState(emailVal, passwordVal);
// }
//
// class _submitButtonState extends State<submitButton> {
//   final String emailVal;
//   final String passwordVal;
// _submitButtonState(this.emailVal, this.passwordVal);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         //after the login REST api call && response code ==200
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         if(emailVal == "admin@gmail.com" && passwordVal == "1234"){
//           prefs.setString('email', 'admin@gmail.com');
//           prefs.setString('password', '1234');
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (BuildContext ctx) => Home()));
//         }
//         else(){
//          print("data is not valid");
//         };
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.symmetric(vertical: 15),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Colors.grey.shade200,
//                   offset: Offset(2, 4),
//                   blurRadius: 5,
//                   spreadRadius: 2)
//             ],
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [Colors.deepOrange, Colors.orangeAccent])),
//         child: Text(
//           'Login Now',
//           style: TextStyle(fontSize: 20, color: Colors.white),
//         ),
//       ),
//
//     );
//   }
// }




