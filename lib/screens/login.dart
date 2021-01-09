import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/authentcation/dialogBox.dart';
import 'package:resresturant/authentcation/validator.dart';
import 'package:resresturant/models/user_model.dart';
import 'package:resresturant/providers/user_provider.dart';
import 'package:resresturant/screens/home.dart';
import 'package:resresturant/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resresturant/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_text_form.dart';
import 'home_silver.dart';

class Login extends StatefulWidget {
  static String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading=false;
  bool KeepMeLogedIn=false;
  final auth = Auth();
  final valid = Validator();
  DialogBox dialog = new DialogBox();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PassWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.red,
      body: (!_loading)?Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "to".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "your account".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            // height: 500,
            height: MediaQuery.of(context).size.height * 0.30,
            color: Colors.red,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100, left: 30, right: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                                controller: _EmailController,
                                validator: valid.ValidateMail,
                                decoration: InputDecoration(
                                    hintText: "Enter your Email")),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                                controller: _PassWordController,
                                validator: valid.pwdValidator,
                                decoration: InputDecoration(
                                    hintText: "Enter your passWord")),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Theme(
                                  data:ThemeData(unselectedWidgetColor: Colors.red),
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.red,

                                    value: KeepMeLogedIn,
                                    onChanged: (value) {
                                      setState(() {
                                        KeepMeLogedIn = value;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Remember me ',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.red,
                                  onPressed: ()async {

                                    if(KeepMeLogedIn==true){
                                      keepUserLoggedIn();
                                    }
                                    setState(() {
                                      _loading=true;
                                    });
                                   /* final authuser =
                                    Provider.of<ProviderUser>(
                                        context,listen: false);*/
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                               try{
                                 final uuser=   await    auth.SignIn(_EmailController.text, _PassWordController.text).then((uuser) async{
                                   print("asmaaaaaaaaaaaaaaaaaaaaaaaa");
                                  print(uuser.user.email);
                                   DocumentSnapshot userDoc =
                                       await Firestore.instance
                                       .collection('User')
                                       .document(uuser.user.uid)
                                       .get();
                                   saveUserData(uuser.user.uid);

                                   Provider.of<ProviderUser>(
                                       context,listen: false)
                                       .userData =
                                       User.fromDoc(userDoc);
                                   Navigator.of(context).push(
                                     MaterialPageRoute<void>(
                                         builder: (_) => home()),
                                   );

                                 print("Emaillllllllllllllllllllllllllllllllll");
                                 print( Provider.of<ProviderUser>(
                                     context,listen: false)
                                     .userData.Email);

                                   setState(() {
                                     _loading=false;
                                   });
                                   _EmailController.text='';
                                   _PassWordController.text='';
                                 });
                               }
                               catch(e){
                                 dialog.information(
                                     context, 'sorry', e.message);
                                 print(e.message);
                                 setState(() {
                                   _loading=false;
                                 });
                               }

                                     }
                                  },
                                  child: Text(

                                    "LOGIN",
                                    style: TextStyle(color: Colors.white),
                                  ),

                                  hoverColor: Colors.blue,
                                ),
                                SizedBox(
                                 height: 5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Regisster(),
                                        ),
                                      );
                                    },
                                    child: Text("create account?",style: TextStyle(fontSize: 15),))
                              ],
                            )
                          ],
                        ),
                      ),
                    )

                    //  Container(child: Text("ttt"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ):Loading(),
    );
  }

  Widget Loading(){
    return Center(child: CircularProgressIndicator(),);
  }
  void keepUserLoggedIn() async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool('KkeepMeLoggedIn', KeepMeLogedIn);


  }
  void saveUserData(String userId) async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    sharedPreferences.setString('userId', userId);

  }
}
