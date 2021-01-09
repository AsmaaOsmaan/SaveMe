import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/models/user_model.dart';
import 'package:resresturant/providers/user_provider.dart';

import 'chat.dart';
import 'const.dart';
class MainScreenTest extends StatefulWidget {
  @override
  _MainScreenTestState createState() => _MainScreenTestState();
}

class _MainScreenTestState extends State<MainScreenTest> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ProviderUser>(context);
    return Scaffold(
      appBar: AppBar(title: Text('chats'),backgroundColor: Colors.red,),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            // List


            // Loading
            Positioned(
              child: isLoading
                  ? Container(
                child: Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
                ),
                color: Colors.white.withOpacity(0.8),
              )
                  : Container(),
            )
          ],
        ),
        //onWillPop: onBackPress,
      ),
    );
  }

  Widget buildItem(BuildContext context, User user) {
    if (user.DocumentID == 'currentUserId') {
      return Container();
    } else {

      return Container(
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
      );
    }
  }
}
