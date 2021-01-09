
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_shop/child/Screens/profile_add_friend_screen.dart';
//import 'package:flutter_shop/child/Screens/profile_friends_screen.dart';
//import 'package:flutter_shop/child/Screens/profile_screen.dart';
//import 'package:flutter_shop/group/update_comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../provider_data.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/chat/main_screen_test.dart';
import 'package:resresturant/models/user_model.dart';
import 'package:resresturant/providers/user_provider.dart';

//import '../user_data.dart';

class SearchScreen extends StatefulWidget {
  final String documentID;

  const SearchScreen({Key key, this.documentID}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

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
        backgroundColor: Colors.white,

        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              size: 30.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
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
      body: _users == null
          ? Center(
        child: Text('Search for a user'),
      )
          : FutureBuilder(
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
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              User user = User.fromDoc(snapshot.data.documents[index]);
              return _buildUserTile(user);
            },
          );
        },
      ),
    );

  }
  static Future<QuerySnapshot> searchUsers(String name) {

   Future<QuerySnapshot> users =
    Firestore.instance.collection('User')
     .where('UserName', isGreaterThanOrEqualTo:  name).getDocuments();

    return users;
  }
}