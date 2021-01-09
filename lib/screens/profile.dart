import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resresturant/services/firestore.dart';
import 'package:resresturant/widgets/profile_clipper.dart';

class Profile extends StatefulWidget {
  final String documentID;
  @override
  _ProfileState createState() => _ProfileState();

  Profile(this.documentID ,{Key key}) : super(key: key);
}

class _ProfileState extends State<Profile> {
  Store  store=Store();
  final Firestore _firestore=Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(future:Firestore.instance
          .collection('User')
          .document(widget.documentID)
          .get(),builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.hasError){
            return Center(child: Text('Erorr'));
          }
        return  SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: Image(
                      height: 300.0,
                      width: double.infinity,
                      image: NetworkImage('https://images.wallpaperscraft.com/image/smile_grass_mood_54205_1280x720.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image(
                          height: 120.0,
                          width: 120.0,
                          image: NetworkImage('https://images.wallpaperscraft.com/image/smile_grass_mood_54205_1280x720.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      snapshot.data['UserName'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child:  IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.black,
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 0.1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Email',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                snapshot.data['Email'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'phone',
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                snapshot.data['Phone'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 30.0),

              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 0.1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'type',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                snapshot.data['Type'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Address',
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                snapshot.data['Address'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        );
        } else {
          return Center(child: Text('Loading...'),);
        }
      } ,
      )









      /*SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: Image(
                      height: 300.0,
                      width: double.infinity,
                      image: NetworkImage('https://images.wallpaperscraft.com/image/smile_grass_mood_54205_1280x720.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image(
                          height: 120.0,
                          width: 120.0,
                          image: NetworkImage('https://images.wallpaperscraft.com/image/smile_grass_mood_54205_1280x720.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                     'Asmaa',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child:  IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.black,
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 0.1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'email',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                               'asmaa@gmail.com',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'phone',
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                '01112545',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 30.0),

              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 0.1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'type',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                'femal',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Adress',
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                'Giza/Badrashen',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),*/
      );


  }
}
