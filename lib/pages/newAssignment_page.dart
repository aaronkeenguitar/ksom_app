import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/assignment.dart';
import '../models/user.dart';

class CreateAssignmentPage extends StatefulWidget {
  @override
  _CreateAssignmentPageState createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  int _keenKoins = 0;
  String _imageUrl = '';
  String _videoUrl = '';

  @override
  Widget build(BuildContext context) {
    final assignmentProvider = Provider.of<AssignmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Assignment'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Keen Koins'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _keenKoins = int.parse(value!),
              ),
              // Add widgets to upload image and video
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newAssignment = Assignment(
                      id: DateTime.now().toString(),
                      title: _title,
                      description: _description,
                      keenKoins: _keenKoins,
                      imageUrl: _imageUrl,
                      videoUrl: _videoUrl,
                      createdBy: Provider.of<User>(context, listen: false).user.id,
                      assignedTo: [], // Add logic to assign to specific students
                    );
                    assignmentProvider.addAssignment(newAssignment);
                    Navigator.pop(context);
                  }
                },
                child: Text('Create Assignment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}