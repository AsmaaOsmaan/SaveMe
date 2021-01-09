import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/dateBicker.dart';
import 'package:resresturant/providers/user_provider.dart';
import 'package:resresturant/screens/add_post_screen.dart';
import 'package:resresturant/screens/home.dart';
import 'package:resresturant/screens/login.dart';
import 'package:resresturant/screens/profile.dart';
import 'package:resresturant/screens/register.dart';
import 'package:resresturant/screens/home_silver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('loading'),
              ),
            ),
          );
        } else  {
          isUserLoggedIn = snapshot.data.getBool('KkeepMeLoggedIn') ?? false;
        // getUserData(context);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ProviderUser>(
                create: (context) => ProviderUser(),
              ),
            ],
            child: MaterialApp(

              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? home.id : Login.id,
              routes: {
                Login.id:(context)=>Login(),

                home.id:(context)=>home(),

              },
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
             // home: Regisster(),
            ),
          );
        }
      },
    );
  }
  
}
