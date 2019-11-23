import 'package:flutter/material.dart';

import '../widgets/image_input_widget.dart';

class PlaceAddScreen extends StatefulWidget {
  static const routeName = '/place-add';

  @override
  _PlaceAddScreenState createState() => _PlaceAddScreenState();
}

class _PlaceAddScreenState extends State<PlaceAddScreen> {
  final _titleController = TextEditingController();

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
                      SizedBox(height: 10,),
                      ImageInputWidget(),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
