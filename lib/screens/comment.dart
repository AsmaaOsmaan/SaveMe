
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/providers/user_provider.dart';
class Comment extends StatefulWidget {
  final String  PostID;
  @override
  _CommentState createState() => _CommentState();

  Comment(this.PostID);
}

class _CommentState extends State<Comment> {
  int  numm=0;
  DocumentReference documentReference =
  Firestore.instance.collection("Comment").document();
  final commentrefrence = Firestore.instance.collection('Comment');
  TextEditingController _commentController= TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40,left: 15,right: 15,bottom: 20),

                child: SingleChildScrollView(
                  child:
                   /*   CircleAvatar(
                        backgroundImage: ExactAssetImage(
                            'assets/images/photo_profile.png'),
                        radius: 24,
                      ),*/
               //       SizedBox(width: 5,),
                      Form(
                        key:_formKey ,
                        child: Column(
                          children: <Widget>[
                            ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 100,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                              child: TextFormField(

                                maxLines: null,
                                controller: _commentController,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'please enter the comment ';
                                  }
                                  return null;
                                },


                                decoration: InputDecoration(
                                  hintText: ' Write Your Comment',
                                  //   hintText: hint,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 15),
                                    child: CircleAvatar(
                                      backgroundImage: ExactAssetImage(
                                          'assets/images/photo_profile.png'),
                                      radius: 24,
                                    ),
                                  ),
                                  suffixIcon:IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed:  ()async{
                                      final auth =
                                      Provider.of<ProviderUser>(context, listen: false);
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        try {
                                          await commentrefrence.document().setData({
                                            'Comment': _commentController.text,
                                            //  'CommentId': documentReference.documentID,
                                            'CommentOwnerId': auth.userData.DocumentID,
                                            'CommentOwnerName':auth.userData.UserName,
                                            'PostID':widget.PostID,
                                            'timestamp': DateTime.now().toString(),
                                          }).then((uuser) async{
                                            _commentController.text='';

                                          });



                                        } catch (e) {
                                          print(e.message);
                                        }
                                      }
                                    },
                                  ),


                               /*   GestureDetector(
                                      onTap: ()async{
                                        final auth =
                                        Provider.of<ProviderUser>(context, listen: false);
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          try {
                                            await commentrefrence.document().setData({
                                              'Comment': _commentController.text,
                                              //  'CommentId': documentReference.documentID,
                                              'CommentOwnerId': auth.userData.DocumentID,
                                              'CommentOwnerName':auth.userData.UserName,
                                              'PostID':widget.PostID,
                                              'timestamp': DateTime.now().toString(),
                                            }).then((uuser) async{
                                              _commentController.text='';

                                            });



                                          } catch (e) {
                                            print(e.message);
                                          }
                                        }
                                      },
                                      child: Icon(Icons.send)),*/
                                  filled: true,
                                  fillColor: Colors.grey,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.grey
                                      )

                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.grey
                                      )

                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.grey
                                      )

                                  ),
                                ),

                              ),
                            ),
                            /*   RaisedButton(
                                child: Text('comment'),
                                onPressed: ()async{
                                  final auth =
                                  Provider.of<ProviderUser>(context, listen: false);
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    try {
                                      await commentrefrence.document().setData({
                                        'Comment': _commentController.text,
                                        //  'CommentId': documentReference.documentID,
                                        'CommentOwnerId': auth.userData.DocumentID,
                                        'CommentOwnerName':auth.userData.UserName,
                                        'PostID':widget.PostID,
                                        'timestamp': DateTime.now().toString(),
                                      }).then((uuser) async{
                                        _commentController.text='';

                                      });



                                    } catch (e) {
                                      print(e.message);
                                    }
                                  }
                                },
                              )*/
                          ],
                        ),
                      ),

                ),

              ),

              Expanded(
                     // height: 600,
                      child: StreamBuilder(

                        stream: Firestore.instance.collection('Comment').where('PostID',isEqualTo:widget.PostID).snapshots(),

                        builder: (BuildContext context, AsyncSnapshot snapshot) {


                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          if (snapshot.hasData)
                           numm= snapshot.data.documents.length;
                          switch  (snapshot.connectionState) {
                            case ConnectionState.waiting: return new Text('Loading...');

                            default:
                              return new  Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50)),
                                  ),
                                  child: ListView.builder(
                                      itemCount: numm,
                                      itemBuilder: (context, postion) {
                                        return   Card(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: CircleAvatar(
                                                      backgroundImage: ExactAssetImage(
                                                          'assets/images/photo_profile.png'),
                                                      radius: 24,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            //  snapshot.data['PostOwnerId']
                                                            snapshot.data.documents[postion]
                                                            ['CommentOwnerName'],
                                                            style: TextStyle(
                                                                color: Colors.grey.shade600,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600),
                                                          ),

                                                          //   Text(" @ch_meyers", style: TextStyle(color: Colors.grey)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        snapshot.data.documents[postion]
                                                        ['Comment'],
                                                        style: TextStyle(color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              /*Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,

                                                  children: <Widget>[

                                                    Text(
                                                      snapshot.data.documents[postion]
                                                      ['Comment'],
                                                      style: TextStyle(color: Colors.grey.shade900,fontSize: 15),
                                                    ),

                                                  ],
                                                ),
                                              ),*/


                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              );
                          }
                        },























 ///////////////////////////////////



















                      ),
                    ),



            ],
          ),
        ),
      ),
    );
  }
}
