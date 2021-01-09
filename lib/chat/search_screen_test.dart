

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resresturant/models/user_model.dart';

import 'chat.dart';
import 'const.dart';
import 'main_screen_test.dart';

class SearchScreenTest extends StatefulWidget {
  @override
  _SearchScreenTestState createState() => _SearchScreenTestState();
}

class _SearchScreenTestState extends State<SearchScreenTest> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  _buildUserTile(User user) {
    return MainScreenTest();
  }
  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,

        title: TextField(
          cursorColor: Colors.red,
          controller: _searchController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(

              Icons.search,
              size: 30.0,
              color: Colors.red,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.red,
              ),
              onPressed: _clearSearch,
            ),
            filled: true,
          ),
          onSubmitted: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _users = searchUsers(input);
              });
            }
          },
        ),
      ),
      body:(_users == null)?Center(
        child: Text('Search for a user'),
      ):FutureBuilder(
        future: _users,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: Text("no data"),
        );
      }
      if (snapshot.data.documents.length == 0) {
        return Center(
          child: Text('No users found! Please try again.'),
        );
      }
      else{
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            User user = User.fromDoc(snapshot.data.documents[index]);


            return Center(child: Container(
              child: FlatButton(
                child: Row(
                  children: <Widget>[
                    Material(
                      child: user.photoUrl!= null
                          ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          width: 50.0,
                          height: 50.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: user.photoUrl,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      )
                          : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'UserName: ${user.UserName}',
                                style: TextStyle(color: primaryColor),
                              ),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                            ),
                            /*   Container(
                        child: Text(
                          'About me: ${document['aboutMe'] ?? 'Not available'}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )*/
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(
                            peerId: user.DocumentID,
                            //   peerAvatar: document['photoUrl'],
                            peerAvatar: (user.photoUrl!=null)?user.photoUrl:'https://www.google.com/search?q=non+profile+pic&sxsrf=ALeKk02364dyi4udg1foBlViji0rbocjkA:1592759148352&tbm=isch&source=iu&ictx=1&fir=-CDMr_vDhatL5M%253A%252CgUHdLmYj-vnBtM%252C_&vet=1&usg=AI4_-kSQdbM__oM-kP_GfAXWStMEkgtW9g&sa=X&ved=2ahUKEwid8_-ZspPqAhXCD2MBHXy3CggQ9QEwCHoECAYQHg#imgrc=-CDMr_vDhatL5M:',

                          )));
                },
                color: greyColor2,
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
            ));
          //  _buildUserTile(user);
          },
        );
      }
    }
      )
      
    );
  }
  static Future<QuerySnapshot> searchUsers(String name) {

    Future<QuerySnapshot> users =
    Firestore.instance.collection('User')
        .where('UserName', isEqualTo:  name).getDocuments();

    return users;
  }
}
