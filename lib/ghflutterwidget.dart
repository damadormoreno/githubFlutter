import 'package:flutter/material.dart';
import 'strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'member.dart';

class GHFlutterState extends State<GHFlutterWidget>{
  var _members = <Member>[];
  final _biggerFonts = const TextStyle(fontSize: 18.0);


  @override
  void initState() {
    super.initState();

    _loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(Strings.apptitle),
      ),
      body: new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          },
      )
    );
  }

  Widget _buildRow(int i){
    return new ListTile(
      title: new Text("${_members[i].login}", style: _biggerFonts,),
      leading: new CircleAvatar(
        backgroundColor: Colors.green,
        backgroundImage: new NetworkImage(_members[i].avatar),
      ),
    );
  }

  _loaddata() async {
    String dataurl = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataurl);
    setState((){
      final membersJSON = JSON.decode(response.body);

      for (var memberJSON in membersJSON){
        final member = new Member(memberJSON["login"], memberJSON["avatar_url"]);
        _members.add(member);
      }
    });
  }
}

class GHFlutterWidget extends StatefulWidget {
  @override
   createState() => new GHFlutterState();

}