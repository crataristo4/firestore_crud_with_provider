import 'dart:convert';

import 'package:firestore_crud_with_provider/model/Users.dart';
import 'package:firestore_crud_with_provider/provider/user_provider.dart';
import 'package:firestore_crud_with_provider/services/github_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  Users? _users;
  List<Users>? _list;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _users = Provider.of<UserProvider>(context).getUsers();
      GithubService(userName: _users!.login).fetchFollowing().then((following) {
        Iterable list = json.decode(following.body);
        setState(() {
          _list = list.map((model) => Users.fromJson(model)).toList();
        });
      });
    });
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              leading: Icon(Icons.arrow_back_ios),
              title: Text("details"),
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage("${_users!.avatarUrl}"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("${_users!.login}"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                height: 600,
                child: _list != null
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          "${_list![index].avatarUrl}"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: _list!.length,
                      )
                    : Container(
                        child: Center(
                          child: Text('loading'),
                        ),
                      ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
