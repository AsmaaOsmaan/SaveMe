import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/authentcation/dialogBox.dart';
import 'package:resresturant/authentcation/validator.dart';
import 'package:resresturant/models/user_model.dart';
import 'package:resresturant/providers/user_provider.dart';
import 'package:resresturant/screens/home.dart';
import 'package:resresturant/screens/home_silver.dart';
import 'package:resresturant/screens/login.dart';
import 'package:resresturant/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Regisster extends StatefulWidget {
  @override
  _RegissterState createState() => _RegissterState();
}

class _RegissterState extends State<Regisster> {
  bool _loading=false;
  final _formKey = GlobalKey<FormState>();
  DialogBox dialog = new DialogBox();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final userrefrence = Firestore.instance.collection('User');
  DocumentReference documentReference =  Firestore.instance.collection("User").document();
  final auth = Auth();
  final valid = Validator();
  String _radioValue = 'female';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _adressController.dispose();
    _confirmPasswordController.dispose();
    _typeController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body:(!_loading)? Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "register".toUpperCase(),
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
                  "create account".toUpperCase(),
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
                              controller: _userNameController,
                                validator: valid.ValidateUser,
                                decoration:
                                    InputDecoration(hintText: "User Name")),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                                validator: valid.ValidateMail,
                                controller: _emailController,
                                decoration:
                                    InputDecoration(hintText: " Email")),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: valid.Validatephone,
                              controller: _phoneController,
                              keyboardType:  TextInputType.phone,
                              decoration: InputDecoration(hintText: " phone"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(

                                controller: _adressController,
                                validator: valid.ValidateAdrees,
                                decoration:
                                    InputDecoration(hintText: " Address")),
                           /* SizedBox(
                              height: 30,
                            ),*/
                           /* TextFormField(
                                validator: valid.ValidateType,
                                controller: _typeController,
                                decoration: InputDecoration(hintText: " type")),*/
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                                validator: valid.pwdValidator,
                                controller: _passwordController,
                                decoration:
                                    InputDecoration(hintText: "  Password")),
                            SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Radio(
                                  activeColor: Colors.red,
                                  value: 'female',
                                  groupValue: _radioValue,
                                  onChanged: (value){
                                    setState(() {
                                      _radioValue=value;
                                    });
                                  },
                                ),
                                new Text(
                                  'female',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  activeColor: Colors.red,
                                  value: 'male',
                                  groupValue: _radioValue,
                                  onChanged: (value){
                                    setState(() {
                                      _radioValue=value;
                                    });
                                  },
                                ),
                                new Text(
                                  'male',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),


                              ],
                            ),


                            SizedBox(
                              height: 10,
                            ),
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _loading=true;
                                    });
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      try {
                                  final authResilt=    await auth.SignUp(
                                                _emailController.text.trim(),
                                                _passwordController.text.trim())
                                            .then((authResilt) async {
                                          await userrefrence.document(authResilt.user.uid).setData({
                                            'DocumentID':authResilt.user.uid,
                                            'UserName': _userNameController.text,
                                            'Email': _emailController.text,
                                            'Phone': _phoneController.text,
                                            'PassWord':
                                                _passwordController.text,
                                            'Type': _radioValue,
                                            'Address':_adressController.text
                                            
                                          }).then((uuser)async {

                                            print(authResilt.user.email);
                                            DocumentSnapshot userDoc =
                                                await Firestore.instance
                                                .collection('User')
                                                .document(authResilt.user.uid)
                                                .get();
                                            print("asmaaaaaa22222222222222222222222");
                                            print(userDoc.data);
                                            Provider.of<ProviderUser>(
                                                context,listen: false)
                                                .userData =
                                                User.fromDoc(userDoc);
                                            _radioValue='femal';
                                           // _typeController.text = '';
                                            _passwordController.text = '';
                                            _emailController.text = '';
                                            _phoneController.text = '';
                                            _emailController.text = '';
                                            _userNameController.text='';
                                            _adressController.text='';
                                          });
                                          print('add');
                                        });

                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (_) => home()),
                                        );
                                      } catch (e) {
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
                                    "REGISTER",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.red,
                                  //hoverColor: Colors.blue,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Already have account?"),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(

                                    onTap: (){
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                            builder: (_) => Login()),
                                      );
                                    },

                                    child: Text("Click me",style: TextStyle(color: Colors.red),)),
                                SizedBox(
                                  height: 50,
                                ),
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
}
