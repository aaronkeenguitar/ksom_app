import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class UpdatePhotoUrlWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Photo URL'),
          onChanged: (value) {
            userProvider.updatePhotoUrl(value);
          },
        ),
        Text('Current Photo URL: ${userProvider.user?.photoUrl ?? 'No photo URL'}'),
      ],
    );
  }
}