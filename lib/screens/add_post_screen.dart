import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resresturant/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool _loading=false;
  File _image1, _image2, _image3, _image4;
  String imageurl;

  TextEditingController _DetailsController = TextEditingController();
  TextEditingController _Name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DocumentReference documentReference =
      Firestore.instance.collection("Post").document();

  // final userrefrence = Firestore.instance.collection('Date');
  double _height;
  double _width;
  Future getImage(File requierdImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      requierdImage = image;
    });
  }

  Future getImageFromCamera(File requierdImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      requierdImage = image;
    });
  }

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Add Post'),
      ),
      body: (!_loading)?Padding(
        padding: EdgeInsets.only(right: 20, top: 20, left: 20),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(

                        controller: _DetailsController,
                        maxLines: 10,
                        //   maxLengthEnforced: true,
                        decoration: InputDecoration(

                            //contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            hintText: ' Details'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _Name,
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(

                          hintText: ' Child Name',
                          //  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     /* Row(
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.photo_filter),
                        ],
                      ),*/
                     Row(
                       children: <Widget>[
                         _displayImagesGrids(),
                         _displayImagesGridsCamera(),
                       ],
                     ),
                      Container(
                       // width: _width,
                     //   height: _height,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Choose Date',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    width: _width / 1.7,
                                    height: _height / 9,
                                    margin: EdgeInsets.only(top: 30),
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 40),
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (String val) {
                                        _setDate = val;
                                      },
                                      decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          // labelText: 'Time',
                                          contentPadding:
                                              EdgeInsets.only(top: 0.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Choose Time',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectTime(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 30),
                                    width: _width / 1.7,
                                    height: _height / 9,
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 40),
                                      textAlign: TextAlign.center,
                                      onSaved: (String val) {
                                        _setTime = val;
                                      },
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _timeController,
                                      decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          // labelText: 'Time',
                                          contentPadding: EdgeInsets.all(5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(

                        color: Colors.red,
                        child: Text('Add '),
                        onPressed: () async {
                          setState(() {
                            _loading=true;
                          });
                          final auth =
                              Provider.of<ProviderUser>(context, listen: false);
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if(_image1!=null)

                              imageurl= await UploadImage(_image1);


                            //  String imageurl2= await UploadImage(_image2);
                            // String imageurl3= await UploadImage(_image3);
                            else if(_image4!=null)

                              imageurl=await UploadImage(_image4);

                            try {
                              await documentReference.setData({
                                'Details': _DetailsController.text,
                                'Name': _Name.text,
                                'Day': _dateController.text,
                                'hours': _timeController.text,
                                'DocumentId': documentReference.documentID,
                                'PostOwnerId': auth.userData.DocumentID,
                                'images':imageurl,
                                'PostOwnerName': auth.userData.UserName,
                                'timestamp': DateTime.now().toString(),
                              }).then((uuser) async{
                                setState(() {
                                  _loading=false;
                                });
                                _DetailsController.text='';
                                imageurl=null;
                                _Name.text='';
                                _dateController.text = DateFormat.yMd().format(DateTime.now());

                                _timeController.text = formatDate(
                                    DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
                                    [hh, ':', nn, " ", am]).toString();

                              });



                            } catch (e) {
                              print(e.message);
                              setState(() {
                                _loading=false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ):Loading(),
    );
  }
  /////upload image////////////////

  Future<String> UploadImage(File image) async {
    String name = Random().nextInt(1000).toString() + '_child';
    final StorageReference storageReference =
        FirebaseStorage().ref().child(name);
    final StorageUploadTask UploadTask = storageReference.putFile(image);
    StorageTaskSnapshot respons = await UploadTask.onComplete;
    String URL = await respons.ref.getDownloadURL();

    return URL;
  }

  Widget _displayImagesGrids() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Icon(
                Icons.photo_filter,

                //color: Colors.teal,
              ),
              onTap: () async {
                var image =
                    await ImagePicker.pickImage(source: ImageSource.gallery);

                setState(() {
                  _image1 = image;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _displayImagesGridsCamera() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    var image =
                        await ImagePicker.pickImage(source: ImageSource.camera);

                    setState(() {
                      _image4 = image;
                    });
                  }),
            )
          ],
        )
      ],
    );
  }
  Widget Loading(){
    return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),);
  }
}
