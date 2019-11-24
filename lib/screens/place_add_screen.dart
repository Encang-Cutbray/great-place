import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import '../widgets/image_input_widget.dart';

class PlaceAddScreen extends StatefulWidget {
  static const routeName = '/place-add';

  @override
  _PlaceAddScreenState createState() => _PlaceAddScreenState();
}

class _PlaceAddScreenState extends State<PlaceAddScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File imagePick) {
    _pickedImage = imagePick;
  }

  void _savePlace() async {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ImageInputWidget(_selectImage),
                    ],
                  ),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton.icon(
                  elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.add),
                  label: Text(
                    'Add Place',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _savePlace),
            ),
          ],
        ),
      ),
    );
  }
}
