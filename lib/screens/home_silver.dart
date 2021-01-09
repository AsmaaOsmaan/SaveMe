import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/chat/chat.dart';
import 'package:resresturant/chat/fullPhoto.dart';
import 'package:resresturant/chat/main_screen.dart';
import 'package:resresturant/models/user_model.dart';
import 'package:resresturant/providers/user_provider.dart';
import 'package:resresturant/screens/add_post_screen.dart';
import 'package:resresturant/screens/dialog_box_post.dart';
import 'package:resresturant/screens/profile.dart';
import 'package:resresturant/screens/register.dart';
import 'package:resresturant/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comment.dart';

class home extends StatefulWidget {
  static String id = 'home';
  @override
  _homeState createState() => _homeState();
}
enum popOutMenu{
  SIGNOUT
}

class _homeState extends State<home> {

  int  numm=0;
  Auth _auth=Auth();
  DialogBoxPost dialogPost=DialogBoxPost();
  TextStyle _hashtagestyle = TextStyle(
    color: Colors.orange,
  );
  @override
  Widget build(BuildContext context) {
    getUserData(context);
    final auth= Provider.of<ProviderUser>(
        context,listen: false);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
              //  Icon(Icons.more_vert)
                _popOutMenu(context),
              ],
              leading: Container(),
              backgroundColor: Colors.red,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) => AddPostScreen()),
                            );
                          //  dialogPost.information(context);
                          },

                          child: Icon(Icons.add,color: Colors.white)),
                      Text("SaveMe",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          )),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) => Profile(auth.userData.DocumentID)),
                            );
                          },

                          child: Icon(Icons.person,color: Colors.white)),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) => MainScreen()),
                            );
                          },

                          child: Icon(Icons.chat_bubble,color: Colors.white,)),

                    ],
                  ),
                  background:

                  Image.asset(
                    'assets/images/help.jpg',
                    fit: BoxFit.cover,
                  ),


              ),
            ),
          ];
        },
        body:  StreamBuilder(
          //snapshot.data
          //stream: Firestore.instance.collection('User').where('ParentID',isEqualTo: auth.userData.uid).snapshots(),
          stream: Firestore.instance.collection('Post').snapshots(),

          builder: (BuildContext context, AsyncSnapshot snapshot) {


            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            if(snapshot.hasData)
              numm= snapshot.data.documents.length;
            switch (snapshot.connectionState) {
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
                  return Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: GestureDetector(
                                onTap: () {

                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (_) => Profile(snapshot.data.documents[postion]
                                        ['PostOwnerId'])),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: ExactAssetImage(
                                      'assets/images/photo_profile.png'),
                                  radius: 24,
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                   //  snapshot.data['PostOwnerId']
                  snapshot.data.documents[postion]
                  ['PostOwnerName'],
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
                                  ['timestamp'],
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[

                              Text(
                                snapshot.data.documents[postion]
                                ['Details'],
                                style: TextStyle(color: Colors.grey.shade900,fontSize: 15),
                              ),
                              Text(
                              "Date ::${  snapshot.data.documents[postion]
                              ['Day']}",
                                style: TextStyle(color: Colors.grey.shade900,fontSize: 15),
                              ),
                              Text(
                                "Time::${snapshot.data.documents[postion]
                                ['hours']}",
                                style: TextStyle(color: Colors.grey.shade900,fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        ( snapshot.data.documents[postion]['images']!=null)? SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: GestureDetector(
                              onTap: () {

                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                      builder: (_) => FullPhoto(url:snapshot.data.documents[postion]['images'])),
                                );
                              },
                              child: Image(
                                image:  NetworkImage( snapshot.data.documents[postion]
                                ['images']),
                               /* ExactAssetImage(
                                    'assets/images/photo_profile.png'),*/
                                fit: BoxFit.cover,
                              ),
                            )):Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                      builder: (_) => Comment(snapshot.data.documents[postion]
                                      ['DocumentId'])),
                                );
                              },
                              child:Container(child: Row(
                                children: <Widget>[
                                  Icon(Icons.comment),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Comment",
                                    style: _hashtagestyle,
                                  ),
                                ],
                              ))
                            ),
                            SizedBox(width: 80,),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Chat(
                                                    peerId: snapshot.data.documents[postion]
                                                    ['PostOwnerId'],
                                                    //   peerAvatar: document['photoUrl'],
                                                    peerAvatar: (snapshot.data.documents[postion]['photoUrl']!=null)?snapshot.data.documents[postion]['photoUrl']:'https://www.google.com/search?q=non+profile+pic&sxsrf=ALeKk02364dyi4udg1foBlViji0rbocjkA:1592759148352&tbm=isch&source=iu&ictx=1&fir=-CDMr_vDhatL5M%253A%252CgUHdLmYj-vnBtM%252C_&vet=1&usg=AI4_-kSQdbM__oM-kP_GfAXWStMEkgtW9g&sa=X&ved=2ahUKEwid8_-ZspPqAhXCD2MBHXy3CggQ9QEwCHoECAYQHg#imgrc=-CDMr_vDhatL5M:',

                                                  )));
                                        },
                                        child: Container(child: Row(
                                          children: <Widget>[
                                            Icon(Icons.chat_bubble),
                                            SizedBox(width: 5,),
                                            Text(
                                              "ChatMe",
                                              style: _hashtagestyle,
                                            ),
                                          ],
                                        ))
                                      )),
                                ],
                              ),
                            )
                            //












                            //
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        );
            }
          },
        )



















        /*Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)),
            ),
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, postion) {
                  return Card(
                    child: Column(
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
                                      "Cheristin meyers",
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
                                  "fri day,12 may2017 ,14.30",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "WE also take about the future og work as the robots",
                            style: TextStyle(color: Colors.grey.shade900),
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Image(
                              image: ExactAssetImage(
                                  'assets/images/photo_profile.png'),
                              fit: BoxFit.cover,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                " COMMENT",
                                style: _hashtagestyle,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          "CONTACT",
                                          style: _hashtagestyle,
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),*/
      ),
    );
  }
  Widget _popOutMenu(BuildContext context){

    return PopupMenuButton<popOutMenu>(itemBuilder:(context){
      return [
        PopupMenuItem<popOutMenu>(
          value: popOutMenu.SIGNOUT,
          child:Text("SIGNOUT"),
        ),





      ];

    },onSelected: (popOutMenu menu)async{
      await _auth.SignOut();
      Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (_) => Regisster()),
      );
    },icon: Icon(Icons.more_vert),
    );
  }


  Future  <SharedPreferences>getUserData(BuildContext context)async{
    SharedPreferences shared= await SharedPreferences.getInstance();
    String id= shared.getString('userId');
    // String id=snapshot.data.getString('userId');
    DocumentSnapshot userDoc =
    await Firestore.instance
        .collection('User')
        .document(id)
        .get();


    Provider.of<ProviderUser>(
        context,listen: false)
        .userData =
        User.fromDoc(userDoc);
  }
}
