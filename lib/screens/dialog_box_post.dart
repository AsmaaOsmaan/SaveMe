import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resresturant/authentcation/validator.dart';
import 'package:resresturant/services/auth.dart';

import '../dateBicker.dart';

class DialogBoxPost{
  DocumentReference documentReference =  Firestore.instance.collection("Post").document();
  final auth = Auth();
  final valid = Validator();

  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PassWordController = TextEditingController();


  information(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return
            AlertDialog(
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Center(
                child: Row(

                  children: <Widget>[
                    Icon(Icons.wrap_text, color: Color.fromRGBO(37, 47, 83, 10.0)),
                    SizedBox(width: 10.0),
                    Text("Add Post",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),

              content: Container(
                height: 400.0,
                width: 400.0,
                child:SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                    maxLines: 10,
                           //   maxLengthEnforced: true,


                              decoration: InputDecoration(
                                  //contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),


                                  hintText: ' Details'
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,

                              decoration: InputDecoration(
                                  hintText: ' name of child',
        //  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Icon(Icons.camera_alt),
                                SizedBox(width: 10,),
                                Icon(Icons.photo_filter),
                              ],
                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  //color: Colors.amber,
                  child: Text('OK',style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                  ),),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );



































      /*    AlertDialog(
           // title: Text(title),
            content:SingleChildScrollView(
                child:Column(
                  children: <Widget>[
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'please Enter Details'
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'please Enter the name of child'
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                )
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: (){
                  return Navigator.pop(context);
                },
              )
            ],
          );*/
        }
    ) ;
  }
}