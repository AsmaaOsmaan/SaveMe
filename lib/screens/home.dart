import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/providers/user_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextStyle _hashtagestyle = TextStyle(
    color: Colors.orange,
  );
  @override
  Widget build(BuildContext context) {
    final auth= Provider.of<ProviderUser>(
        context,listen: false);
    return Scaffold(
       backgroundColor: Colors.red,
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  auth.userData.Email.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "YOUR".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "CHILD".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            // height: 500,
            height: MediaQuery.of(context).size.height * 0.20,
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
          ),
        ],
      ),
    );
  }
}
