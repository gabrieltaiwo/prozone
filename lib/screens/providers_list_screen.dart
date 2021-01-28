import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prozone/model/providers_model.dart' as model;
import 'package:prozone/widget/prov_alart_dialog.dart';

import 'add_providers_screen.dart';

class ProvidersListScreen extends StatefulWidget {
  @override
  _ProvidersListScreenState createState() => _ProvidersListScreenState();
}

class _ProvidersListScreenState extends State<ProvidersListScreen> {
  List<model.Providers> providersList = List();
  model.Providers provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getProvidersData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('List of Providers'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //color: Colors.blue,
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProvidersScreen(),
              ),
            );
            //AddProvidersScreen();
            // showModalBottomSheet (
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) =>
            //       SingleChildScrollView (
            //         child: Container (
            //           padding: EdgeInsets.only (
            //               bottom: MediaQuery
            //                   .of (context)
            //                   .viewInsets
            //                   .bottom),
            //           child: AddProvidersScreen (),
            //         ),
            //       ),
            // );
          },
        ),
        body: _buildProviderList(),
      ),
    );
  }

  Widget _buildProviderList() {
    if (providersList != null || providersList.isNotEmpty) {
      return ListView.builder(
        itemCount: providersList.length,
        itemBuilder: (context, index) {
          return FlatButton(
            child: ListTile(
              title: Text(providersList[index].name),
              // subtitle: Text(providerslist[index].description),
            ),
            onPressed: () => showProvAlertDialog(context, index),
          );
        },
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  showProvAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProvAlertDialog(providersList[index]);
      },
    );
  }

  //{HttpHeaders.authorizationHeader: token},
  //{"Content-Type": "application/json"}
  //https://pro-zone.herokuapp.com/documentation/v1.0.0#/Provider/get_providers

  Future<List<model.Providers>> getProvidersData() async {
    const providerURL = "https://pro-zone.herokuapp.com/providers";
    // const token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjExNTYzNjEzLCJleHAiOjE2MTQxNTU2MTN9.e5Df8V75KU44Hz4IG1ilKby0ptkJzX7hFcbX5XZ-EEI";
    String requestURL = '$providerURL';
    http.Response response = await http.get(requestURL, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjExNTYzNTg3LCJleHAiOjE2MTQxNTU1ODd9.KLKN7sJGyoz8y2tFHCiYbTkxRFqtJUuhSzaxtuDedco'
    });

    var res = response.body;
    var list = json.decode(res) as List;
    list.forEach((dynamic e) => providersList.add(model.Providers.fromJson(e)));

    setState(() {});
    return [];
  }
}
