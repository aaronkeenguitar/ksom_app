import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'editProfile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user?.name ?? 'Home'),
          leading: IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoUrl ?? 'https://via.placeholder.com/150'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.feed)),
              Tab(icon: Icon(Icons.assignment)),
              Tab(icon: Icon(Icons.subscriptions)),
              Tab(icon: Icon(Icons.leaderboard)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Add your tab views here
            Center(child: Text('Feed')),
            Center(child: Text('Assignments')),
            Center(child: Text('Subscriptions')),
            Center(child: Text('Leaderboard')),
          ],
        ),
      ),
    );
  }
}